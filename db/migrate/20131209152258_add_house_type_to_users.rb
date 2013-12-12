class AddHouseTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :house_type, :string
  end
end
