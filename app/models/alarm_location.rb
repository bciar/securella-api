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

class AlarmLocation < ApplicationRecord
  belongs_to :alarm

  validates :alarm_id, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
