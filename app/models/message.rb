# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  alarm_id    :integer
#  company_id  :integer
#  guardian_id :integer
#  admin_id    :integer
#  message     :string
#  level       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :company
end
