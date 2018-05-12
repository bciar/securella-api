# frozen_string_literal: true

class CreateGuardianLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :guardian_locations do |t|
      t.integer :guardian_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
