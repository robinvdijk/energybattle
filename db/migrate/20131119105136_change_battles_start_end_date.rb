class ChangeBattlesStartEndDate < ActiveRecord::Migration
  def change
    change_column :battles, :start_date, :date
    change_column :battles, :end_date, :date	  
  end
end
