FactoryGirl.define do
  factory :team_relation do
    sequence(:user_id) { |n| n+1 }
    battle_id 1
    team "opponent_team"
  end
end