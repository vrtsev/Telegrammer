# frozen_string_literal: true

redis_url = "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/#{ENV['REDIS_DB']}"

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, namespace: 'sidekiq_data' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, namespace: 'sidekiq_data' }
end

Sidekiq::Statistic.configure do |config|
  config.log_file = 'log/sidekiq.log'
  config.last_log_lines = 10_000
  config.max_timelist_length = 500_000
end
