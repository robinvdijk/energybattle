namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_battles_to_join
    make_own_battles
    make_notifications
  end
end
# maar eerst jezelf aan voor dat je populate doet
def make_users
  19.times do |n|
    name = Faker::Name.name
    email = "test-#{n}@test.nl"
    amount = [3300,4200,4600,5500]
    user = User.create!(name: name,email: email, password: "password", password_confirmation: "password")
    user = Reading.create!(user_id: user.id, battle_id: :null, created_at: 1.week.ago, updated_at: 1.week.ago, amount: amount.shuffle.first)
  end
end

def make_battles_to_join
  users = User.where.not(id: 1)
  1.times do |n|
    users.each do |user|
      Battle.create!(host_id: user.id, opponent_id: :null , winner_id: user.id, theme: "energy", status: "pending", start_date: "2014-01-02", end_date: "2014-01-09", duration: 7, player_limit: 12, title: "Join-#{user.id-1}", game_type: "beste" )
    end
  end
end

def make_own_battles
  current_user = User.find(1)
  users = User.where.not(id: 1)
  amount = [3300,4200,4600,5500]
  Reading.create!(user_id: current_user.id, battle_id: :null, created_at: 1.week.ago, updated_at: 4.weeks.ago, amount: amount.shuffle.first )
  6.times do |n|
    battle = Battle.create!(host_id: current_user.id, theme: "energy", status: "started", start_date: Date.today, end_date: 7.days.from_now.to_date, duration: 7, title: "Host-#{n+1}", player_limit: (n+1)*2, game_type: "beste")

    order = users.shuffle
    order_id = order.map { |o| o.id }

    # Host team_realtions
    (n).times do |i|
      TeamRelation.create!(user_id: order_id[i], battle_id: battle.id, team: "host_team", status: "joined")
    end
    # Opponent team_relations
    (n+1).times do |i|
      TeamRelation.create!(user_id: order_id[-1-i], battle_id: battle.id, team: "opponent_team", status: "joined")
    end

    # Reading voor jezelf in de battle
    rand(2..7).times do |t|
      Reading.create!(user_id: current_user.id, battle_id: battle.id, created_at: battle.start_date+t, updated_at: battle.start_date+t, amount: current_user.readings.first.amount + (current_user.readings.first.amount/365*t))
    end

    order = battle.users
    # Readings voor battlelid
    order.each do |user|
      rand(2..7).times do |t|
        Reading.create!(user_id: user.id, battle_id: battle.id, created_at: battle.start_date+t, updated_at: battle.start_date+t, amount: user.readings.first.amount + (user.readings.first.amount/365*t))
      end
    end
  end
end

def make_notifications
  3.times do |i|
    Notification.create!(notification_type: "general", receiver_id: 1, sender_id: i+2, battle_id: i+1, message: "general notification #{i}")
  end
end