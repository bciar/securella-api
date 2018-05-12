# frozen_string_literal: true

# == Schema Information
#
# Table name: alarms
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string           default("open")
#  address    :string
#

require 'rails_helper'

RSpec.describe Alarm, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:alarm)).to be_valid
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :latitude }
    it { is_expected.to validate_presence_of :longitude }
  end
end
