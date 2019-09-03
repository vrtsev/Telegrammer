REDIS = Redis.new(
  user:     ENV['REDIS_USER'],
  password: ENV['REDIS_PASSWORD'],
  host:     ENV['REDIS_HOST'],
  port:     ENV['REDIS_PORT'],
  db:       ENV['REDIS_DB']
)

REDIS.ping