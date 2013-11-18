class RemoveColumnsFromUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :email, :string
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :email
  end
end
