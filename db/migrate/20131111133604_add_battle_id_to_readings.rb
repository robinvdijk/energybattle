class AddBattleIdToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :battle_id, :integer
  end
end
