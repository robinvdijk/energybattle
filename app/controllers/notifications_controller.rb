class NotificationsController < ApplicationController
  before_action :set_notification

  def accept
    if @notification.notification_type == 'invite'
      relation = TeamRelation.where(battle_id: @notification.battle_id, user_id: @notification.receiver_id, :status => 'invited').first
      if relation
        relation.update_attributes(status: 'joined')
        @notification.destroy
        redirect_to battles_path(@notification.battle_id), success: "Je hebt een battle succesvol gejoined!"
      else
        redirect_to root_path, error: "Er is iets fouts gegaan"
      end
    elsif @notification.notification_type == 'kick_request'
      team_relation = TeamRelation.where(battle_id: @notification.battle_id, user_id: @notification.receiver_id).first.destroy
      @notification.destroy
      redirect_to :back
    end
  end

  def destroy
    # relation = TeamRelation.where(:user_id => @notification.receiver_id, :battle_id => @notification.battle_id, :status => 'invited').first
    @notification.destroy
    # relation.delete
    redirect_to root_path, notice: 'De uitnodiging is succesvol afgewezen'
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to root_path, success: "Nieuwe notificatie aangemaakt"
    else
      flash[:alert] = "Er missen een aantal instellingen"
      render :action => "new"
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:notification_type, :battle_id, :sender_id, :receiver_id, :message)
  end
end
