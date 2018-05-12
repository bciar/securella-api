# frozen_string_literal: true

class AddImageToUsers < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :users, :image
  end

  def self.down
    remove_attachment :users, :image
  end
end
