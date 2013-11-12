FactoryGirl.define do
  factory :battle do
    host_id 2
    opponent_id { Faker::Number.digit }
    winner_id { Faker::Number.digit }
    theme "Energy"
    status "pending"
    title "Test"

    factory :invalid_battle do
      opponent_id nil
    end
  end
end