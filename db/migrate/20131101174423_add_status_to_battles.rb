class AddStatusToBattles < ActiveRecord::Migration
  def change
    add_column :battles, :status, :string
  end
end
