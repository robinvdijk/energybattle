class BattlesController < TeamRelationsController
  before_action :set_battle, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:new, :create, :show, :edit, :update]
  helper_method :sort_column, :sort_direction

  def index
    @battles = Battle.order(sort_column + ' ' + sort_direction).paginate(per_page: 10, page: params[:page])
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

    def battle_params
      params.require(:battle).permit(:host_id, :opponent_id, :winner_id, :theme, :status)
    end

    def sort_column
      Battle.column_names.include?(params[:sort]) ? params[:sort] : "theme"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end