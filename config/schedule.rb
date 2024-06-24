set :output, 'log/cron_log.log'
ENV.each { |k, v| env(k, v) }
set :environment, ENV.fetch('RAILS_ENV', nil)

every '0 3 * * *' do
  rake 'clean:clean_data'
end
