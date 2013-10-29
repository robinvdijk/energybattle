FactoryGirl.define do
  factory :single_battle do
    sequence(:opponent_id) { |n| :user_id + n}
    winner_id = :user_id
    theme "energy"
  end
end