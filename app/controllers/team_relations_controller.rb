class TeamRelationsController < ApplicationController

  helper_method :create_team_relation

  def destroy

  end

  def team_relation
    r = TeamRelation.new
    r.user_id = @current_user.id
    r.battle_id = @battle.id
    r.save
  end

  # def initialize_team_b
  #   r = TeamRelation.new
  #   r.battle_id = @battle.id
  #   r.save
  # end

  def find_host
    @host = TeamRelation.where(user_id: current_user.id, battle_id: @battle.id).first.user
  end

  def find_members_team_a
    @members_team_a = TeamRelation.where(battle_id: @battle.id)
  end

end