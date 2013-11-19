namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_battles
  end
end

def make_users

  5.times do |n|
    name = Faker::Name.name
    email = "test-#{n}@test.nl"
    User.create!(name: name,
                 email: email,
                 password: "password",
                 password_confirmation: "password")
  end
end

def make_battles
  users = User.all
  1.times do |n|
    users.each { |user| Battle.create!(host_id: user.id, opponent_id: :null , winner_id: user.id, theme: "energy", status: "pending", start_date: "2013-11-12", end_date: "2013-11-19", duration: 604800, player_limit: 12, title: "Title-#{user.id+1}" ) }
  end
end
