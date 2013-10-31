class CreateTeamRelations < ActiveRecord::Migration
  def change
    create_table :team_relations do |t|
      t.integer :user_id
      t.integer :single_battle_id

      t.timestamps
    end
  end
end
