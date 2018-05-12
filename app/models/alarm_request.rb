# frozen_string_literal: true

# == Schema Information
#
# Table name: alarm_requests
#
#  id         :integer          not null, primary key
#  alarm_id   :integer
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string           default("open")
#

class AlarmRequest < ApplicationRecord
  belongs_to :alarm
  belongs_to :company
end
