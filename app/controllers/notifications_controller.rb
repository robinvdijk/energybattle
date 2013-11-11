class NotificationsController < ApplicationController
  before_action :set_notification

  def accept

	  relation = TeamRelation.where(:user_id => @notification.receiver_id, :battle_id => @notification.battle_id, :status => 'invited').first
	  if relation
		  relation.update_attributes(status: 'joined')
		  @notification.destroy
	     redirect_to battles_path(@notification.battle_id), notice: "Je hebt een battle succesvol gejoined!"
	  else
	     redirect_to root_path, error: "Er is iets fouts gegaan"
	  end
  end

  def destroy
    @notification.destroy
    redirect_to root_path, notice: 'De uitnodiging is succesvol afgewezen'
  end

  private

	# Use callbacks to share common setup or constraints between actions.
	def set_notification
		@notification = Notification.find(params[:id])
	end
end
