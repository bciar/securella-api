# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :alarm_id
      t.integer :company_id
      t.integer :guardian_id
      t.integer :admin_id
      t.string :message
      t.string :level

      t.timestamps
    end
  end
end
