class BattlesController < TeamRelationsController
  before_action :set_battle, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:new, :create, :show, :edit, :update]
  # before_action :find_host, only: [:show, :edit, :update]
  before_action :find_host_team_members, :find_opponent_team_members, only: [:show]

  helper_method :user_in_one_team

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
      host_team_relation
      redirect_to @battle
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
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def user_in_one_team
    TeamRelation.where(user_id: @current_user.id, battle_id: @battle.id).count == 0
  end

  def destroy
    @battle.destroy
    redirect_to battle_path
  end

  def set_battle
    @battle = Battle.find(params[:id])
  end

  def battle_params
    params.require(:battle).permit(:host_id, :opponent_id, :winner_id, :theme)
  end
end