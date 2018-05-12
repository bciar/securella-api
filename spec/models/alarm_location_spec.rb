# frozen_string_literal: true

# == Schema Information
#
# Table name: alarm_locations
#
#  id         :integer          not null, primary key
#  alarm_id   :integer
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe AlarmLocation, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:alarm_location)).to be_valid
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of :alarm_id }
    it { is_expected.to validate_presence_of :latitude }
    it { is_expected.to validate_presence_of :longitude }
  end
end
