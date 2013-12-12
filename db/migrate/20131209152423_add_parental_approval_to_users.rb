class AddParentalApprovalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :parental_approval, :boolean
  end
end
