# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:update]
  before_action :authenticate_user!, only: [:create_alarm, :update_alarm, :close_alarm, :alarm_status]

  def create_alarm
    @alarm = Alarm.new(alarm_params)
    @alarm.user_id = current_user.id

    if @alarm.save
      DelegateAlarmJob.perform_later @alarm.id
      Message.create(alarm_id: @alarm.id, user_id: @current_user.id, message: 'User created a new alarm', level: 'INFO')
      render json: @alarm
    else
      render json: @alarm.errors, status: :unprocessable_entity
    end
  end

  def update_alarm; end

  def close_alarm
    update_alarm_status('closed')
  end

  def alarm_status
    @alarm = current_user.alarms.last
    if @alarm.nil?
      render json: no_alarm
    else
      render json: @alarm
    end
  end

  def update
    if @user.update!(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def no_alarm
    {
      id: 0,
      status: false,
      latitude: 0.0,
      longitude: 0.0
    }
  end

  def update_alarm_status(status)
    @alarm = current_user.alarms.last
    return head(:forbidden) if @alarm.nil?

    if @alarm.update_attribute(:status, status)
      Message.create(alarm_id: @alarm.id, message: 'Alarm updated by user: ' + status, level: 'INFO')
      render json: @alarm
    else
      render json: @alarm.errors, status: :unprocessable_entity
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(params[:email])
    logger.debug @user.inspect
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:image, :email)
  end

  def alarm_params
    params.require(:alarm).permit(:latitude, :longitude)
  end
end
