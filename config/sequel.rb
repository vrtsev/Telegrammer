# Configuration
DB_CONNECTION_PARAMS = {
  adapter:    :postgres,
  user:       ENV['POSTGRES_USER'],
  password:   ENV['POSTGRES_PASSWORD'],
  host:       ENV['POSTGRES_HOST'],
  port:       ENV['POSTGRES_PORT'],
  database:   ENV['POSTGRES_DATABASE'],
  logger:     Telegram::BotManager::Logger.new(formatter: TelegramManager::Logger::SequelFormatter.new)
}

# Global extensions
Sequel.extension :migration

# Database connection
DB = Sequel.connect(DB_CONNECTION_PARAMS)

# Database extensions
DB.extension(
  :pagination,
  :pg_json,
  :pg_array
)

# Plugins
Sequel::Model.plugin :timestamps, update_on_create: true, allow_manual_update: true
Sequel::Model.strict_param_setting = false