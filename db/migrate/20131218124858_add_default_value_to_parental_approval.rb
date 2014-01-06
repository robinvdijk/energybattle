class AddDefaultValueToParentalApproval < ActiveRecord::Migration
  def up
    change_column :users, :parental_approval, :boolean, :default => false
  end

  def down
    change_column :users, :parental_approval, :boolean, :default => nil
  end
end
