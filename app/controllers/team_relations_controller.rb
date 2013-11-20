class TeamRelationsController < ApplicationController
  before_action :set_team_relation, only: [:destroy, :switch]
  helper_method :user_in_one_team, :find_team_members, :not_accepted

  def create
    @team_relation = TeamRelation.new(team_relation_params)
    if @team_relation.save
      redirect_to :back
    end
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

  def invite
	  TeamRelation.create!(:user_id => params[:id], :battle_id => params[:battle_id], :status => 'invited', :team => 'opponent_team')
	  Notification.create!(:notification_type => 'invite', :battle_id => params[:battle_id], :receiver_id => params[:id], :sender_id => current_user.id)
	  redirect_to :back
  end

  def user_in_one_team(user)
    TeamRelation.where(user_id: user.id, battle_id: @battle.id).count == 0
  end

  def find_team_members(team)
    TeamRelation.where(battle_id: @battle.id, team: "#{team}_team")
  end

private
  def set_team_relation
    @team_relation = TeamRelation.find(params[:id])
  end

  def team_relation_params
    params.require(:team_relation).permit(:user_id, :battle_id, :team, :status)
  end
end