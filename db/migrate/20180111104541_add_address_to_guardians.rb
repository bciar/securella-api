# frozen_string_literal: true

class AddAddressToGuardians < ActiveRecord::Migration[5.1]
  def change
    add_column :guardians, :address, :string
  end
end
