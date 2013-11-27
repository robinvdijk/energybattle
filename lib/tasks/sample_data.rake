namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_battles_to_join
    make_own_battles
  end
end
# eerst zelf registreren voordat je dit uitvoert
def make_users
  19.times do |n|
    name = Faker::Name.name
    email = "test-#{n}@test.nl"
    amount = [3300,4200,4600,5500]
    user = User.create!(name: name,email: email, password: "password",password_confirmation: "password")
    user = Reading.create!(user_id: user.id, battle_id: :null, meter: "big_black_dot.jpg", created_at: 1.week.ago, updated_at: 1.week.ago, amount: amount.shuffle.first)
  end
end

def make_battles_to_join
  users = User.all
  1.times do |n|
    users.each do |user|
      Battle.create!(host_id: user.id, opponent_id: :null , winner_id: user.id, theme: "energy", status: "pending", start_date: "2013-11-12", end_date: "2013-11-19", duration: 604800, player_limit: 12, title: "Title-#{user.id+1}" )
    end
  end
end

def make_own_battles
  current_user = User.find(1)
  users = User.where.not(id: 1)
  6.times do |n|
    battle = Battle.create!(host_id: current_user.id, theme: "energy", status: "started", start_date: Date.today+n, end_date: 7.days.from_now.to_date+n, duration: 7, title: "Title-#{n}", player_limit: n*2)

    order = users.shuffle
    order_id = order.map { |o| o.id }

    # current_user relation
    TeamRelation.create!(user_id: current_user.id, battle_id: battle.id, team: "host_team", status: "joined")
    # Host team_realtions
    (1*n-1).times do |i|
      TeamRelation.create!(user_id: order_id[i], battle_id: battle.id, team: "host_team", status: "joined")
    end
    # Opponent team_relations
    (1*n).times do |i|
      TeamRelation.create!(user_id: order_id[i], battle_id: battle.id, team: "opponent_team", status: "joined")
    end

    order.each do |user|
      rand(1..7).times do |t|
        Reading.create!(user_id: user.id, battle_id: battle.id, meter: "big_black_dot.jpg", created_at: (Date.today+t).to_date, amount: user.readings.first.amount + (user.readings.first.amount/365*t))
      end
    end
  end
end