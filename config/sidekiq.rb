Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'], namespace: "sidekiq_data" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'], namespace: "sidekiq_data" }
end

Sidekiq::Statistic.configure do |config|
  config.log_file = 'log/sidekiq.log'
  config.last_log_lines = 10_000
  config.max_timelist_length = 500_000
end