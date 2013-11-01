namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_single_battles
  end
end

def make_users

  9.times do |n|
    first_name = Faker::Name.first_name
    email = "test-#{n+1}@test.nl"
    User.create!(first_name: first_name,
                 email: email)
  end
end

def make_single_battles
  users = User.all
  1.times do |n|
    users.each { |user| SingleBattle.create!(host_id: user.id, opponent_id: :null , winner_id: user.id, theme: "Energy") }
    users.each { |user| TeamRelation.create!(user_id: user.id, single_battle_id: user.id, team: "host_team")}
  end
end
