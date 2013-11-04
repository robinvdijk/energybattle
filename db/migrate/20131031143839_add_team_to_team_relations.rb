class AddTeamToTeamRelations < ActiveRecord::Migration
  def change
    add_column :team_relations, :team, :string
  end
end
