class CreateSingleBattles < ActiveRecord::Migration
  def change
    create_table :single_battles do |t|
      t.integer :user_id
      t.integer :opponent_id
      t.integer :winner_id
      t.string :theme

      t.timestamps
    end
  end
end
