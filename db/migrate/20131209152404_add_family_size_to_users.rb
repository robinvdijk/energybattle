class AddFamilySizeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :family_size, :integer
  end
end
