class CreateSingleBattles < ActiveRecord::Migration
  def change
    create_table :single_battles do |t|
      t.integer :host_id
      t.integer :opponent_id
      t.integer :winner_id
      t.string :thema

      t.timestamps
    end
  end
end
