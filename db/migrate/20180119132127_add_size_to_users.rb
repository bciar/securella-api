class AddSizeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :size, :string
  end
end
