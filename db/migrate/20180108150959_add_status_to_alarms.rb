# frozen_string_literal: true

class AddStatusToAlarms < ActiveRecord::Migration[5.1]
  def change
    add_column :alarms, :status, :string, default: 'open'
  end
end
