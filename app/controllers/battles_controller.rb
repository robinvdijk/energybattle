class BattlesController < TeamRelationsController
  before_action :set_battle, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:new, :create, :show, :edit, :update]

  def index
    if params[:theme]
      @battles = Battle.where(:theme => params[:theme])
    else
      @battles = Battle.all
    end
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
      @battle.end_date = @battle.start_date + @battle.duration
      @battle.save
      flash[:notice] = "Nieuwe battle aangemaakt"
      redirect_to @battle
    else
      flash[:alert] = "Er missen een aantal instellingen"
      render :new
    end
  end

  def edit
  end

  def update
    if @battle.update_attributes(battle_params)
      redirect_to @battle
    else
      redirect_to :back
    end
  end

  def destroy
    @battle.destroy
    redirect_to battle_path
  end

private
  def set_battle
      @battle = Battle.find(params[:id])
  end

  def twitter_url_for(url, text)
    link_to "Share this url", "http://twitter.com/share?url=#{url}&text=#{text}"
  end

  def battle_params
    params.require(:battle).permit(:host_id, :opponent_id, :winner_id, :theme, :game_type, :start_date, :end_date, :access, :title, :player_limit, :duration, :status)
  end




end