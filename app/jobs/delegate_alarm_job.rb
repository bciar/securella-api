# frozen_string_literal: true

class DelegateAlarmJob < ApplicationJob
  queue_as :default

  def perform(id)
    set_alarm(id)
    find_guards if @alarm.present?

    return if @guards.empty?

    @guards.pluck(:company_id).uniq.each do |company_id|
      @alarm_request = AlarmRequest.new(company_id: company_id, alarm_id: @alarm.id)
      if @alarm_request.save
        Message.create(alarm_id: @alarm.id, user_id: @alarm.user_id, company_id: company_id, message: 'Created Alarm request for ' + Company.find(company_id).name, level: 'INFO')
      else
        Message.create(alarm_id: @alarm.id, user_id: @alarm.user_id, company_id: company_id, message: 'Failed to create alarm request for ' + Company.find(company_id).name, level: 'INFO')
      end
    end

    @alarm.update_attribute(:status, 'requested')
    Message.create(alarm_id: @alarm.id, user_id: @alarm.user_id, message: 'Changed Alarm status to REQUESTED', level: 'INFO')
  end

  private

  def find_guards
    center_point = [@alarm.latitude, @alarm.longitude]
    box = Geocoder::Calculations.bounding_box(center_point, 10)
    @guards = Guardian.where(status: 'available').within_bounding_box(box)
  end

  def fail_alarm
    @alarm.update_attribute(:status, 'failed')
    Message.create(alarm_id: @alarm.id, user_id: @alarm.user_id, message: 'Changed Alarm status to FAILED', level: 'INFO')
    Message.create(alarm_id: @alarm.id, user_id: @alarm.user_id, message: 'Could not find nearby guards!', level: 'CRITICAL') if @guards.empty?
  end

  def set_alarm(id) # rubocop:disable Naming/AccessorMethodName
    @alarm = Alarm.find(id)
    Message.create(message: 'JOB could not find alarm data', level: 'CRITICAL') if @alarm.blank?
  end
end
