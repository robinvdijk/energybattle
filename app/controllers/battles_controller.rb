class BattlesController < TeamRelationsController
  before_action :set_battle, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:new, :create, :show, :edit, :update]
  before_action :find_host, only: [:show, :edit, :update]

  def index
    @battles = Battle.all
  end

  def show
    @battle = Battle.find(params[:id])
  end

  def new
    @battle = Battle.new
  end

  def create
    @battle = Battle.new(battle_params)
    if @battle.save
      @battle.end_date = @battle.start_date - @battle.duration
      @battle.save
      team_relation
      redirect_to battles_path
    else
      render "new"
    end
  end

  def edit
    @battle = Battle.find(params[:id])
  end

  def update
    @battle = Battle.find(params[:id])
    if @battle.update_attributes(battle_params)
      render "edit"
    else
      render "edit"
    end
  end

  def destroy
    @battle.destroy
    redirect_to battle_path
  end

  def team_relation
    r = TeamRelation.new
    r.user_id = @current_user.id
    r.battle_id = @battle.id
    r.save
  end

  def set_battle
    @battle = Battle.find(params[:id])
  end

  def twitter_url_for(url, text)
    link_to "Share this url", "http://twitter.com/share?url=#{url}&text=#{text}"
  end

  def battle_params
    params.require(:battle).permit(:host_id, :opponent_id, :winner_id, :theme, :game_type, :start_date, :end_date, :access, :title, :player_limit, :duration)
  end
end