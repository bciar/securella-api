# frozen_string_literal: true

FactoryGirl.define do
  factory :alarm, class: Alarm do
    user
    latitude 2.345
    longitude 5.678
  end
end
