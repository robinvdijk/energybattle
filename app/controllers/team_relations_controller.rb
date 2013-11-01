class TeamRelationsController < ApplicationController

  helper_method :user_in_one_team

  def destroy
    @team_relation = TeamRelation.find(params[:id])
    @team_relation.destroy
    redirect_to :back
  end

  def new
    @team_relation = TeamRelation.new
  end

  def create
    @team_relation = TeamRelation.new(team_relation_params)
    if @team_relation.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def host_team_relation
    r = TeamRelation.new
    r.user_id = @current_user.id
    r.single_battle_id = @single_battle.id
    r.team = "host_team"
    r.save
  end

  def opponent_team_relation
    r = TeamRelation.new
    r.user_id = @current_user.id
    r.single_battle_id = @single_battle.id
    r.team = "opponent_team"
    r.save
  end

  # def initialize_team_b
  #   r = TeamRelation.new
  #   r.single_battle_id = @single_battle.id
  #   r.save
  # end

  def update
    @team_relation = TeamRelation.find(params[:id])
    if @team_relation = update_attributes(team_relation_params)
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def switch
    @team_relation = TeamRelation.find(params[:id])
    if @team_relation.team == "host_team"
      @team_relation.update_attributes(team: "opponent_team")
      redirect_to :back
    else
      @team_relation.update_attributes(team: "host_team")
      redirect_to :back
    end
  end

  def user_in_one_team
    TeamRelation.where(user_id: @current_user.id).count == 3
  end

  def find_host_team_members
    @host_team_members = TeamRelation.where(single_battle_id: @single_battle.id, team: "host_team").load
  end

  def find_opponent_team_members
    @opponent_team_members = TeamRelation.where(single_battle_id: @single_battle.id, team: "opponent_team").load
  end

  def team_relation_params
    params.require(:team_relation).permit(:user_id, :single_battle_id, :team)
  end

end