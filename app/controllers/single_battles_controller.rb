class SingleBattlesController < TeamRelationsController
  before_action :set_single_battle, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:new, :create, :show, :edit, :update]
  # before_action :find_host, only: [:show, :edit, :update]
  before_action :find_host_team_members, :find_opponent_team_members, only: [:show]

  helper_method :user_in_one_team

  def index
    @single_battles = SingleBattle.all
  end

  def show
    @single_battle = SingleBattle.find(params[:id])
  end

  def new
    @single_battle = SingleBattle.new
  end

  def create
    @single_battle = SingleBattle.new(single_battle_params)
    if @single_battle.save
      host_team_relation
      redirect_to @single_battle
    else
      render "new"
    end
  end

  def edit
    @single_battle = SingleBattle.find(params[:id])
  end

  def update
    @single_battle = SingleBattle.find(params[:id])
    if @single_battle.update_attributes(single_battle_params)
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def user_in_one_team
    TeamRelation.where(user_id: @current_user.id, single_battle_id: @single_battle.id).count == 0
  end

  def destroy
    @single_battle.destroy
    redirect_to single_battle_path
  end

  def set_single_battle
    @single_battle = SingleBattle.find(params[:id])
  end

  def single_battle_params
    params.require(:single_battle).permit(:host_id, :opponent_id, :winner_id, :theme)
  end
end