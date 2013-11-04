class TeamRelationsController < ApplicationController
  before_action :set_team_relation, only: [:destroy, :switch]
  helper_method :user_in_one_team, :find_team_members, :not_accepted

  def create
    @team_relation = TeamRelation.new(team_relation_params)
    redirect_to :back if @team_relation.save
  end

  def destroy
    @team_relation.destroy
    flash[:notice] = "Team en battle verlaten"
    redirect_to battles_path
  end

  def switch
    if @team_relation.team == "host_team"
      @team_relation.update_attributes(team: "opponent_team")
    else
      @team_relation.update_attributes(team: "host_team")
    end
    flash[:notice] = "Verwisseld van team"
    redirect_to :back
  end

  def user_in_one_team(user)
    TeamRelation.where(user_id: user.id, battle_id: @battle.id).count == 0
  end

  def find_team_members(team)
    TeamRelation.where(battle_id: @battle.id, team: "#{team}_team", accepted: true)
  end

  def not_accepted
    TeamRelation.where(user_id: 5, accepted: false)
  end

private
  def set_team_relation
    @team_relation = TeamRelation.find(params[:id])
  end

  def team_relation_params
    params.require(:team_relation).permit(:user_id, :battle_id, :team, :accepted)
  end
end