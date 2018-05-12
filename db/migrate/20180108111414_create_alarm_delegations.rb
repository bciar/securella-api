# frozen_string_literal: true

class CreateAlarmDelegations < ActiveRecord::Migration[5.1]
  def change
    create_table :alarm_delegations do |t|
      t.integer :alarm_id
      t.integer :guardian_id

      t.timestamps
    end
  end
end
