require 'spec_helper'
 
feature 'NotificationCentre' do
  before(:each) do
    @current_user = create(:user)
  end
 
  scenario 'invites new user and creates new notification' do
		@opponent_user = create(:user)

		battle = create(:battle, host_id: @current_user.id)
    visit(battle_path(battle))

		save_and_open_page
    expect{click_link 'Invite'}.to change(Notification, :count).by(1)
		
	end
	
	# scenario 'declines an invitation to battle' do
	# 	battle = create(:battle, host_id: @opponent_user.id)
	# 	noti = create(:notification, sender_id: @opponent_user.id, receiver_id: @current_user.id)
	# 	visit(root_path)
	# 	
	# 	
	#     expect{click_link('Decline')}.to change(Notification, :count).by(-1)
	#     # to change(TeamRelation, :count).by(-1)					
	# end
	
	# scenario 'accepts an invitation to battle' do
	# 	battle = create(:battle, host_id: @opponent_user.id)
	# 	noti = create(:notification, sender_id: @opponent_user.id, receiver_id: @current_user.id)
	# 	visit(root_path)
	# 	
	# 	
	#     expect{click_link('Accept')}.to change(Notification, :count).by(-1)
	#     # to change(TeamRelation, :status).to("joined")
	# 	
	# 	save_and_open_page		
	# end
	

end