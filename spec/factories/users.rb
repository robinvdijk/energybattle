FactoryGirl.define do
  factory :user do
    sequence(:id) { |n| n}
    first_name { "Jeroen" }# Faker::Name.first_name }
    email { Faker::Internet.email }

    factory :user_with_single_battle do
      after(:build) do |user|
        FactoryGirl.create(:single_battle, user: user)
        user.reload
      end
    end
  end
end