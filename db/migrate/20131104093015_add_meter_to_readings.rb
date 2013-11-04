class AddMeterToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :meter, :string
  end
end
