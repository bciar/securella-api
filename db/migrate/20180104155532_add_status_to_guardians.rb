# frozen_string_literal: true

class AddStatusToGuardians < ActiveRecord::Migration[5.1]
  def change
    add_column :guardians, :status, :string, default: 'inactive'
  end
end
