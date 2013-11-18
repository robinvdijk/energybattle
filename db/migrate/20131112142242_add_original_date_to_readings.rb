class AddOriginalDateToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :original_date, :datetime
  end
end
