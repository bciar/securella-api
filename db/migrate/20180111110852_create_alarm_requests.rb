# frozen_string_literal: true

class CreateAlarmRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :alarm_requests do |t|
      t.integer :alarm_id
      t.integer :company_id

      t.timestamps
    end
  end
end
