# frozen_string_literal: true

# == Schema Information
#
# Table name: guardians
#
#  id                     :integer          not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  name                   :string
#  nickname               :string
#  image                  :string
#  email                  :string
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :integer
#  latitude               :float
#  longitude              :float
#  status                 :string           default("inactive")
#  address                :string
#
# Indexes
#
#  index_guardians_on_confirmation_token    (confirmation_token) UNIQUE
#  index_guardians_on_email                 (email) UNIQUE
#  index_guardians_on_reset_password_token  (reset_password_token) UNIQUE
#  index_guardians_on_uid_and_provider      (uid,provider) UNIQUE
#

require 'rails_helper'

RSpec.describe Guardian, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:guardian)).to be_valid
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_confirmation_of :password }
    it { is_expected.to validate_presence_of :company_id }
  end
end
