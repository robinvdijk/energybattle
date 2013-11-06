class AddAcceptedToTeamRelations < ActiveRecord::Migration
  def change
    add_column :team_relations, :accepted, :boolean
  end
end
