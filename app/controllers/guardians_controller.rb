# frozen_string_literal: true

class GuardiansController < ApplicationController
  before_action :authenticate_guardian!
  before_action :set_guardian

  def status
    render json: @guardian.status
  end

  def update_location
    if @guardian.update!(guardian_params)
      render json: @guardian
    else
      render json: @guardian.errors, status: :unprocessable_entity
    end
  end

  def open_alarms
    @delegations = current_guardian.alarm_delegations.where('status = ?', 'open')

    if @delegations.empty?
      render json: no_alarm
    else
      puts @delegations.first.alarm.user.inspect
      render json: alarm_info(@delegations.first)
    end
  end

  def ack_alarm # rubocop:disable Metrics/AbcSize
    @delegation = current_guardian.alarm_delegations.find(request_params[:alarm_id])
    if @delegation.present?
      @delegation.update_attribute(:status, 'responding')
      @delegation.alarm.update_attribute(:status, 'responding')
      current_guardian.update_attribute(:status, 'operating')
      Message.create(alarm_id: @delegation.alarm_id, user_id: @delegation.alarm.user_id, message: 'Changed Alarm status to RESPONDING', level: 'INFO')
      Message.create(alarm_id: @delegation.alarm_id, user_id: @delegation.alarm.user_id, company_id: current_guardian.company.id, message: current_guardian.name + ' responds to the alarm', level: 'INFO')
      render json: @delegation
    else
      Message.create(company_id: current_guardian.company.id, message: current_guardian.name + ' could not be assigned to alarm', level: 'FATAL')
      render json: @delegation
    end
  end

  def deny_alarm
    @delegation = current_guardian.alarm_delegations.find(request_params[:alarm_id])
    if @delegation.present?
      @delegation.update_attribute(:status, 'closed')
      @delegation.alarm.update_attribute(:status, 'requested')
      #TODO: What if this was the last guard?
      current_guardian.update_attribute(:status, 'available')
      Message.create(alarm_id: @delegation.alarm_id, user_id: @delegation.alarm.user_id, message: 'Changed Alarm status to REQUESTED', level: 'INFO')
      Message.create(alarm_id: @delegation.alarm_id, user_id: @delegation.alarm.user_id, company_id: current_guardian.company.id, message: ' denied responding to the alarm', level: 'INFO')
      render json: @delegation
    else
      Message.create(company_id: current_guardian.company.id, message: current_guardian.name + ' could not be assigned to alarm', level: 'FATAL')
      render json: @delegation
    end
  end

  def close_alarm # rubocop:disable Metrics/AbcSize
    @delegation = current_guardian.alarm_delegations.find(request_params[:alarm_id])
    if @delegation.present?
      @delegation.update_attribute(:status, 'closed')
      @delegation.alarm.update_attribute(:status, 'saved')
      current_guardian.update_attribute(:status, 'available')
      #TODO close alarm and update victim data
      Message.create(alarm_id: @delegation.alarm_id, user_id: @delegation.alarm.user_id, company_id: current_guardian.company.id, message: ' Alarm closed by guard: User is safe', level: 'INFO')
      render json: @delegation
    else
      Message.create(company_id: current_guardian.company.id, message: current_guardian.name + ' could not be closed', level: 'FATAL')
      render json: @delegation
    end
  end

  def set_status_occupied
    update_status('occupied')
  end

  def set_status_available
    update_status('available')
  end

  private

  def alarm_info(delegation)
    {
      id: delegation.id,
      status: true,
      location: {
        latitude: delegation.alarm.latitude,
        longitude: delegation.alarm.longitude
      },
      victim: {
        firstname: delegation.alarm.user.firstname,
        lastname: delegation.alarm.user.lastname,
        age: delegation.alarm.user.age,
        gender: delegation.alarm.user.gender,
        size: delegation.alarm.user.size,
        image_url: delegation.alarm.user.image.url(:medium)
      }
    }
  end

  def no_alarm
    {
      id: 0,
      status: false,
      location: {
        latitude: 0.0,
        longitude: 0.0
      },
      victim: {}
    }
  end

  def update_status(status)
    if @guardian.update_attribute(:status, status)
      render json: @guardian
    else
      render json: @guardian.errors, status: :unprocessable_entity
    end
  end

  def set_guardian
    @guardian = current_guardian
  end

  def guardian_params
    params.require(:guardian).permit(:name, :email, :password, :password_confirmation, :latitude, :longitude)
  end

  def request_params
    params.require(:alarm).permit(:alarm_id)
  end
end
