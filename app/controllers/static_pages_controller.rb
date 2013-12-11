class StaticPagesController < ApplicationController
  skip_before_action :logged_in?, only: [:homepage]
  helper_method :sort_column, :sort_direction

  def dashboard
		battles = Battle.all
    team_relations = TeamRelation.where(user_id: current_user.id)
		@current_user_host_battles = Battle.where(host_id: current_user.id)
		@current_user_ended_battles = current_user.battles.where(status: 'finished')
    @battles_joined = team_relations.map { |t| t.battle }
    if params[:theme]
      @battles = battles.where(:theme => params[:theme]).order(sort_column + ' ' + sort_direction)#.paginate(per_page: 5, page: params[:page])
    else
      @battles = Battle.order(sort_column + ' ' + sort_direction)#.paginate(per_page: 5, page: params[:page])
    end
  end

  def homepage
  end

  def gametype

  end

  def sort_column
    Battle.column_names.include?(params[:sort]) ? params[:sort] : "theme"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
private
end