FactoryGirl.define do
  factory :battle do
    host_id 2
    opponent_id { Faker::Number.digit }
    winner_id { Faker::Number.digit }
    theme "Energy"
		start_date "12-11-2013"
    status "Pending"
    title "Test"
		game_type "snelste"

    factory :invalid_battle do
      opponent_id nil
    end
  end
end