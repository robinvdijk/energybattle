class ChangeAcceptedfieldInTeamRelations < ActiveRecord::Migration
  def change
	  remove_column :team_relations, :accepted
     add_column :team_relations, :status, :string	  
  end
end
