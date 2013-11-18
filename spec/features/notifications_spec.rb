require 'spec_helper'
 
feature 'NotificationCentre' do
  before(:each) do
    @current_user = create(:user)
		@opponent_user = create(:user)
  end
 
  scenario 'invites new user and creates new notification' do
		battle = create(:battle, host_id: @current_user.id)
    visit(battle_path(battle))
    expect{click_link 'Invite'}.to change(Notification, :count).by(1)			
  end
	
	scenario 'deletes a notification and teamrelation' do
		battle = create(:battle, host_id: @opponent_user.id)
		noti = create(:notification, sender_id: @opponent_user.id, receiver_id: @current_user.id)
		visit(root_path)
    expect{click_link 'Decline'}.to change(Notification, :count).by(-1)			
    # expect{click_link 'Decline'}.to change(TeamRelation, :count).by(-1)			
		
		save_and_open_page
		
		
	end
	
	scenario 'accepts an invitation to battle' do
	end
	
	scenario 'declines an invitation to battle' do
	end

end