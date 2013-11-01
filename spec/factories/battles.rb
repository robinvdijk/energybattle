FactoryGirl.define do
  factory :battle do
    host_id 1
    opponent_id { Faker::Number.digit }
    winner_id { Faker::Number.digit }
    theme "energy"

    factory :invalid_battle do
      opponent_id nil
    end
  end
end