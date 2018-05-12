# frozen_string_literal: true

FactoryGirl.define do
  factory :user, class: User do
    firstname 'Erwin'
    lastname 'Lottemann'
    sequence(:email) { |n| "user_#{n}@example.com" }
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

    factory :user_with_session do
      transient do
        session_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:session, evaluator.session_count, user: user)
      end
    end

    factory :user_without_name, traits: %i[missing_info skip_validation]
    factory :unconfirmed_user, traits: [:unconfirmed]
  end
end
