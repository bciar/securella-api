# frozen_string_literal: true

FactoryGirl.define do
  factory :alarm_location, class: AlarmLocation do
    alarm
    latitude 2.345
    longitude 5.678
  end
end
