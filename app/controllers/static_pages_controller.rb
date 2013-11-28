class StaticPagesController < ApplicationController
  skip_before_action :check_signin, only: [:homepage]
  skip_before_action :check_notifications, only: [:homepage]
  helper_method :sort_column, :sort_direction

  def dashboard
    @team_relations = TeamRelation.where(user_id: current_user.id)
    @battles_joined = @team_relations.map { |t| t.battle }
    if params[:theme]
      @battles = Battle.where(:theme => params[:theme]).order(sort_column + ' ' + sort_direction).paginate(per_page: 5, page: params[:page])
    else
      @battles = Battle.order(sort_column + ' ' + sort_direction).paginate(per_page: 5, page: params[:page])
    end
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
end