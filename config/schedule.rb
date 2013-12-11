set :environment, 'development'
set :output, 'log/cron.log'

every 2.minutes do
  runner "Reading.test"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end


