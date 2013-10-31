class SingleBattlesController < TeamRelationsController
  before_action :set_single_battle, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:new, :create, :show, :edit, :update]
  before_action :find_host, only: [:show, :edit, :update]

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
      create_team_relation
      redirect_to single_battles_path
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
      render "edit"
    else
      render "edit"
    end
  end

  def destroy
    @single_battle.destroy
    redirect_to single_battle_path
  end

  def team_relation
    r = TeamRelation.new
    r.user_id = @current_user.id
    r.single_battle_id = @single_battle.id
    r.save
  end

  def set_single_battle
    @single_battle = SingleBattle.find(params[:id])
  end

  def single_battle_params
    params.require(:single_battle).permit(:host_id, :opponent_id, :winner_id, :theme)
  end
end