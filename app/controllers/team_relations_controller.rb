class TeamRelationsController < ApplicationController
  def create_team_relation
    @team_relation = TeamRelation.new
  end

  def destroy

  end

  def initialize_team_a
    r = TeamRelation.new
    r.user_id = @current_user.id
    r.single_battle_id = @single_battle.id
    r.save
  end

  # def initialize_team_b
  #   r = TeamRelation.new
  #   r.single_battle_id = @single_battle.id
  #   r.save
  # end

  def find_host
    @host = TeamRelation.where(user_id: current_user.id, single_battle_id: @single_battle.id).first.user
  end

  def find_members_team_a
    @members_team_a = TeamRelation.where(single_battle_id: @single_battle.id)
  end

end