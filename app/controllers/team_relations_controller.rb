class TeamRelationsController < ApplicationController

  helper_method :create_team_relation

  def destroy

  end

  def team_relation
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