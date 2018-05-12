# frozen_string_literal: true

class AddLatitudeAndLongitudeToGuardian < ActiveRecord::Migration[5.1]
  def change
    add_column :guardians, :latitude, :float
    add_column :guardians, :longitude, :float
  end
end
