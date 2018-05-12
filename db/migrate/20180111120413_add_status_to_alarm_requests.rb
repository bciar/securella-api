# frozen_string_literal: true

class AddStatusToAlarmRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :alarm_requests, :status, :string, default: 'open'
  end
end
