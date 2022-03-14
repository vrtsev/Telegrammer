# frozen_string_literal: true

$redis_url = "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/#{ENV['REDIS_DB']}"
REDIS = Redis.new(url: $redis_url)

REDIS.ping
