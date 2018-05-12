# frozen_string_literal: true

class CreateAlarmLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :alarm_locations do |t|
      t.integer :alarm_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
