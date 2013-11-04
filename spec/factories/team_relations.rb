FactoryGirl.define do
  factory :team_relation do
    id 1
    sequence(:user_id) { |n| n+1 }
    battle_id 1
    team "opponent_team"

    factory :invalid_team_relation do
      team nil
    end
  end
end