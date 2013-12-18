class BattlesController < TeamRelationsController
  before_action :set_battle, only: [:show, :edit, :update, :destroy, :kick_request]
  before_action :current_user, only: [:index, :new, :create, :show, :edit, :update]
  helper_method :sort_column, :sort_direction, :current_user_is_host

  def index		
    team_relations = TeamRelation.where(user_id: current_user.id)
    @battles_joined = team_relations.map { |t| t.battle }
    if params[:theme]
      @battles = Battle.where(:theme => params[:theme]).order(sort_column + ' ' + sort_direction)#.paginate(per_page: 3, page: params[:page])
    else
      @battles = Battle.order(sort_column + ' ' + sort_direction)#.paginate(per_page: 10, page: params[:page])
    end
  end

  def show
    @reading = Reading.new
		@battlecount = Battle.count
    calculate
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
      render :action => "new"
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

  def calculate
    teamrelations = TeamRelation.where(battle_id: @battle.id, team: "host_team")
    teamrelations2 = TeamRelation.where(battle_id: @battle.id, team: "opponent_team")
    
    @begin_amount_sum = 0 && @begin_amount_sum2 = 0
    @current_amount_sum = 0 && @current_amount_sum2 = 0
    @energy_savings_sum = 0 && @energy_savings_sum2 = 0
    @readings_sum = 0 && @readings_sum2 = 0

    for relation in teamrelations do
      if relation.user.readings.where(battle_id: @battle.id).any?
        @begin_amount_sum += relation.user.readings.where(battle_id: @battle.id).first.amount
        @current_amount_sum += relation.user.readings.where(battle_id: @battle.id).last.amount
        @energy_savings_sum += (100 - (relation.user.readings.where(battle_id: @battle.id).last.amount.to_f / 3500) * 100)
        @readings_sum += relation.user.readings.where(battle_id: @battle.id).count
      end
    end
    for relation in teamrelations2 do
      if relation.user.readings.where(battle_id: @battle.id).any?
        @begin_amount_sum2 += relation.user.readings.where(battle_id: @battle.id).first.amount
        @current_amount_sum2 += relation.user.readings.where(battle_id: @battle.id).last.amount
        @energy_savings_sum2 += (100 - (relation.user.readings.where(battle_id: @battle.id).last.amount.to_f / 3500) * 100)
        @readings_sum2 += relation.user.readings.where(battle_id: @battle.id).count

      end
    end
  end

  def kick_request
    @battle = Battle.find(params[:id])
    team_relation = TeamRelation.where(:user_id => params[:user_id], :battle_id => @battle.id).first
    notification = Notification.create!(:notification_type => 'kick_request', :battle_id => @battle.id, :sender_id => current_user.id, :receiver_id => 1)
    redirect_to :back

    unless params[:user_id] == @battle.host_id
      TeamRelation.where(user_id: params[:user_id], battle_id: @battle.id).first
      Notification.create!(notification_type: 'kick_request', battle_id: @battle.id, sender_id: current_user.id, receiver_id: params[:user_id])
      redirect_to :back
    end
  end
	

  def current_user_is_host
    @battle.host_id == current_user.id
  end

  def sort_column
    Battle.column_names.include?(params[:sort]) ? params[:sort] : "theme"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

private
  def set_battle
    @battle = Battle.find(params[:id])
  end

  def battle_params
    params.require(:battle).permit!
  end
end

