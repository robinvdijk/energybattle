class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :first_name
    remove_column :users, :email
  end
end
