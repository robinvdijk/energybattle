class AddUserIdToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :user_id, :integer
  end
end
