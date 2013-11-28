class ChangeReadingsAmount < ActiveRecord::Migration
  def change
    change_column_default :readings, :amount, 0
  end
end
