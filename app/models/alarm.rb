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

class Alarm < ApplicationRecord
  validates :user_id, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  belongs_to :user
  has_many :alarm_locations, dependent: :destroy
  has_many :alarm_requests
  has_one :alarm_delegation

  reverse_geocoded_by :latitude, :longitude, address: :location
end
