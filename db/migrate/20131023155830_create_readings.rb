class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :amount

      t.timestamps
    end
  end
end
