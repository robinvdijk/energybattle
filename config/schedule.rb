set :environment, 'development'
set :output, 'log/cron.log'

every 1.day, :at => '12:05 am' do
  runner "Battle.update_battles"
end

every 1.day, :at => '12:01 am' do
  runner "Battle.remove_incomplete"
end




