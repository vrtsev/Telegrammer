REDIS = Redis.new(url: ENV['REDIS_URL'])
REDIS.ping