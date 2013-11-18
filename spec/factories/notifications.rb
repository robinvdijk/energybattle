FactoryGirl.define do
  factory :notification do
		notification_type "invite"
		battle_id 1
		sender_id = 2
		receiver_id = 1
  end
end