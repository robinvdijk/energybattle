namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_battles
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

def make_battles
  users = User.all
  1.times do |n|
    users.each { |user| Battle.create!(host_id: user.id, opponent_id: :null , winner_id: user.id, theme: "energy", status: "pending", start_date: "2013-11-04 13:37:00", end_date: "2013-11-11 13:37:00", duration: 604800, player_limit: 12, title: "Title-#{user.id+1}" ) }
  end
end
