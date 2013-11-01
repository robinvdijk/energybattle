class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.integer :host_id
      t.integer :opponent_id
      t.integer :winner_id
      t.string :theme

      t.timestamps
    end
  end
end
