# frozen_string_literal: true

class AddAddressToAlarms < ActiveRecord::Migration[5.1]
  def change
    add_column :alarms, :address, :string
  end
end
