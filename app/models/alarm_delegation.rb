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

class AlarmDelegation < ApplicationRecord
  belongs_to :alarm
  belongs_to :guardian
end
