# frozen_string_literal: true

FactoryGirl.define do
  factory :guardian_location, class: GuardianLocation do
    guardian
    latitude 2.345
    longitude 5.678
  end
end
