class TeamRelationsController < ApplicationController
  before_action :set_team_relation, only: [:destroy, :switch]

  helper_method :user_in_one_team, :find_team_members

  def new
    @team_relation = TeamRelation.new
  end

  def create
    @team_relation = TeamRelation.new(team_relation_params)
    if @team_relation.save
      redirect_to :back
    end
  end

  def update
    unless @team_relation != update_attributes(team_relation_params)
      redirect_to :back
    end
  end

  def destroy
    if @team_relation.battle.host_id == @team_relation.user_id
      @team_relation.battle.destroy
      @team_relation.destroy
      flash[:success] = "Battle verwijderd"
      redirect_to battles_path
    else
      @team_relation.destroy
      redirect_to :back
    end
  end

  def switch
    if @team_relation.team == "host_team"
      @team_relation.update_attributes(team: "opponent_team")
    else
      @team_relation.update_attributes(team: "host_team")
    end
    redirect_to :back
  end

  def user_in_one_team
    TeamRelation.where(user_id: @current_user.id, battle_id: @battle.id).load.count == 0
  end

  def find_team_members(team)
    TeamRelation.where(battle_id: @battle.id, team: "#{team}_team").load
  end

  def set_team_relation
    @team_relation = TeamRelation.find(params[:id])
  end

  def team_relation_params
    params.require(:team_relation).permit(:user_id, :battle_id, :team)
  end

end