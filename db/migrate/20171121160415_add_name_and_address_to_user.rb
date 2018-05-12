# frozen_string_literal: true

class AddNameAndAddressToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :postal_code, :string
    add_column :users, :age, :string
    add_column :users, :gender, :string
  end
end
