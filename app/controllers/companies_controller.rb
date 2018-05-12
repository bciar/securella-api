# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :authenticate_company!

  def guardians
    @guardians = current_company.guardians.all
    render json: @guardians
  end

  def guardian
    logger.debug(params)
    @guardian = current_company.guardians.find(params[:id])
    render json: @guardian
  end

  def create_guardian
    @guardian = Guardian.new(guardian_params)
    @guardian.company_id = current_company.id
    @guardian.confirm
    @guardian.reload
    @guardian.tokens = nil

    if @guardian.save
      render json: @guardian
    else
      render json: @guardian.errors, status: :unprocessable_entity
    end
  end

  def update_guardian
    @guardian = current_company.guardians.find(params[:id])
    return head(:forbidden) if @guardian.nil?

    if @guardian.update!(guardian_params)
      render json: @guardian
    else
      render json: @guardian.errors, status: :unprocessable_entity
    end
  end

  def inactive_guardians
    @guardians = current_company.guardians.where('status = ?', 'inactive')
    render json: @guardians
  end

  def occupied_guardians
    @guardians = current_company.guardians.where('status = ?', 'occupied')
    render json: @guardians
  end

  def available_guardians
    @guardians = current_company.guardians.where('status = ?', 'available')
    render json: @guardians
  end

  def operating_guardians
    @guardians = current_company.guardians.where('status = ?', 'operating')
    render json: @guardians
  end

  def set_guardian_inactive
    update_guardian_status('inactive')
  end

  def set_guardian_occupied
    update_guardian_status('occupied')
  end

  def set_guardian_available
    update_guardian_status('available')
  end

  def set_guardian_operating
    update_guardian_status('operating')
  end

  def open_alarms
    @requests = current_company.alarm_requests.where('status = ?', 'open')

    if @requests.empty?
      render json: no_alarm
    else
      render json: alarm_info(@requests.first)
    end
  end

  def ack_request # rubocop:disable Metrics/AbcSize
    @request = current_company.alarm_requests.find(request_params[:alarm_id])
    @alarm_delegation = AlarmDelegation.new(guardian_id: request_params[:guard_id], alarm_id: @request.alarm.id)
    if @alarm_delegation.save
      Message.create(
        alarm_id: @request.alarm_id,
        user_id: @request.alarm.user_id,
        company_id: current_company.id,
        guardian_id: @alarm_delegation.guardian.id,
        message: current_company.name + ' assigned '+ @alarm_delegation.guardian.name + ' to the alarm', level: 'INFO'
      )
      @alarm_delegation.guardian.update_attribute(:status, 'operating')
      @request.alarm.update_attribute(:status, 'delegated')
      Message.create(alarm_id: @request.alarm.id, company_id: current_company.id, message: 'Changed Alarm status to DELEGATED', level: 'INFO')

      @request.update_attribute(:status, 'closed')
      @request.alarm.alarm_requests.each do |r|
        Message.create(alarm_id: @request.alarm_id, company_id: r.company.id, message: 'Alarm request for ' + r.company.name + ' closed.', level: 'INFO')
        r.update_attribute(:status, 'closed')
      end
      render json: @alarm_delegation
    else
      Message.create(alarm_id: @request.alarm_id, user_id: @request.alarm.user_id, company_id: current_company.id, message: 'Failed to assign alarm for ' + current_company.name, level: 'INFO')
      @request.update_attribute(:status, 'closed')
      render json: @alarm_delegation.errors, status: :unprocessable_entity
    end
  end

  def alarm_status
    @alarm = Alarm.find(params[:id])
    if @alarm.nil?
      render json: @alarm.errors, status: :unprocessable_entity
    else
      render json: @alarm
    end
  end

  def cancel_delegation
    @guardian = current_company.guardians.find(request_params[:guard_id])
    @alarm = Alarm.find(request_params[:alarm_id])

    if @guardian.nil? || @alarm.nil?
      render json: @request.errors, status: :unprocessable_entity
      Message.create(alarm_id: request_params[:alarm_id], guardian_id: request_params[:guard_id], message: 'Could not cancel alarm', level: 'WARNING')
    else
      @alarm.update_attribute(:status, 'requested')
      @guardian.update_attribute(:status, 'available')
      @guardian.alarm_delegations.find_by_alarm_id(request_params[:alarm_id]).update_attribute(:status, 'canceled')
      Message.create(alarm_id: @request.alarm_id, user_id: @request.alarm.user_id, company_id: current_company.id, message: current_company.name + ' canceled delegation', level: 'INFO')
      Message.create(alarm_id: @request.alarm_id, user_id: @request.alarm.user_id, message: 'Changed Alarm status to REQUESTED', level: 'INFO')
      render json: @request

     #TODO: What if this was the last guard?
    end
  end

  def deny_request
    @request = current_company.alarm_requests.find(request_params[:alarm_id])
    if @request.nil?
      render json: @request.errors, status: :unprocessable_entity
    else
      @request.update_attribute(:status, 'closed')
      Message.create(alarm_id: @request.alarm_id, user_id: @request.alarm.user_id, company_id: current_company.id, message: current_company.name + ' denied to resond to alarm', level: 'INFO')
      render json: @request
    end
  end

  private

  def alarm_info(request)
    guards = []

    center_point = [request.alarm.latitude, request.alarm.longitude]
    box = Geocoder::Calculations.bounding_box(center_point, 10)
    @guards = current_company.guardians.where(status: 'available').within_bounding_box(box)
    @guards.each do |guard|
      guards.push(id: guard.id, name: guard.name, email: guard.email, latitude: guard.latitude, longitude: guard.longitude)
    end

    {
      id: request.id,
      alarm_id: request.alarm.id,
      status: true,
      location: {
        latitude: request.alarm.latitude,
        longitude: request.alarm.longitude
      },
      victim: {
        firstname: request.alarm.user.firstname,
        lastname: request.alarm.user.lastname,
        age: request.alarm.user.age,
        gender: request.alarm.user.gender,
        size: request.alarm.user.size,
        image_url: request.alarm.user.image.url(:medium)
      },
      guards: guards
    }
  end

  def no_alarm
    {
      id: 0,
      alarm_id: 0,
      status: false,
      location: {
        latitude: 0.0,
        longitude: 0.0
      },
      victim: '',
      guards: []
    }
  end

  def update_guardian_status(status)
    @guardian = current_company.guardians.find(params[:id])
    return head(:forbidden) if @guardian.nil?

    if @guardian.update_attribute(:status, status)
      render json: @guardian
    else
      render json: @guardian.errors, status: :unprocessable_entity
    end
  end

  def guardian_params
    params.require(:guardian).permit(:name, :email, :password, :password_confirmation, :status)
  end

  def request_params
    params.require(:alarm).permit(:guard_id, :alarm_id)
  end
end
