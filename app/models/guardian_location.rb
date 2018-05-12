# frozen_string_literal: true

# == Schema Information
#
# Table name: guardian_locations
#
#  id          :integer          not null, primary key
#  guardian_id :integer
#  latitude    :float
#  longitude   :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class GuardianLocation < ApplicationRecord
  belongs_to :guardian

  validates :guardian_id, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
