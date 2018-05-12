# frozen_string_literal: true

class AddGuardianToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :guardians, :company_id, :integer
  end
end
