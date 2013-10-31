FactoryGirl.define do
  factory :user do
    sequence(:id) { |n| n}
    first_name { Faker::Name.first_name }
    email { Faker::Internet.email }

    # factory :user_with_battle do
#       after(:build) do |user|
#         FactoryGirl.create(:battle, user: user)
#         user.reload
#       end
#     end
  end
end