# frozen_string_literal: true
# == Schema Information
#
# Table name: alarm_delegations
#
#  id          :integer          not null, primary key
#  alarm_id    :integer
#  guardian_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :string           default("open")
#

require 'rails_helper'

RSpec.describe AlarmDelegation, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:alarm)).to be_valid
  end
end
