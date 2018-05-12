# frozen_string_literal: true

FactoryGirl.define do
  factory :guardian, class: Guardian do
    company
    name 'Charly'
    sequence(:email) { |n| "guardian_#{n}@example.com" }
    password '1234qwer'
    reset_password_sent_at nil

    trait :unconfirmed do
      confirmed_at nil
    end

    trait :unconfirmed_email do
      sequence(:unconfirmed_email) { |n| "changed_email_#{n}@example.com" }
    end

    trait :missing_info do
      salutation nil
      firstname nil
      lastname nil
    end

    factory :guardian_with_session do
      transient do
        session_count 1
      end

      after(:create) do |guardian, evaluator|
        create_list(:session, evaluator.session_count, guardian: guardian)
      end
    end

    factory :guardian_without_name, traits: %i[missing_info skip_validation]
    factory :unconfirmed_guardian, traits: [:unconfirmed]
  end
end
