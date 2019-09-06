# Configuration
DB_CONNECTION_PARAMS = {
  adapter:    :postgres,
  user:       ENV['POSTGRES_USER'],
  password:   ENV['POSTGRES_PASSWORD'],
  host:       ENV['POSTGRES_HOST'],
  port:       ENV['POSTGRES_PORT'],
  database:   ENV['POSTGRES_DB']
}

# Global extensions
Sequel.extension :migration

# Database connection
db_credentials = DB_CONNECTION_PARAMS
DB = Sequel.connect(db_credentials, logger:  Telegram::BotManager::Logger.new(formatter: Telegram::AppManager::Logger::SequelFormatter.new))

# Database extensions
DB.extension(
  :pagination,
  :pg_json,
  :pg_array
)

# Plugins
Sequel::Model.plugin :timestamps, update_on_create: true, allow_manual_update: true
Sequel::Model.strict_param_setting = false