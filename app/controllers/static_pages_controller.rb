class StaticPagesController < ApplicationController
  skip_before_action :logged_in?, only: [:homepage]
  helper_method :sort_column, :sort_direction, :welcome_message

  def dashboard
    @user = current_user
		battles = Battle.all
    team_relations = TeamRelation.where(user_id: current_user.id)
		@current_user_host_battles = Battle.where(host_id: current_user.id)
		@current_user_ended_battles = current_user.battles.where(status: 'finished')
  end

  def homepage
  end

  def gametype

  end

private
  def sort_column
    Battle.column_names.include?(params[:sort]) ? params[:sort] : "theme"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def welcome_message
    case
    when current_user.sign_in_count == 1
      flash[:notice] = "Welkom op Energybattle, #{current_user.name}. Veel plezier!"
    when current_user.sign_in_count > 1
      flash[:notice] = "Welkom terug, #{current_user.name}."
    end
  end
end