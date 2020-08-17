# frozen_string_literal: true

# Configuration
DB_CONNECTION_PARAMS = {
  adapter: :postgres,
  user: ENV['POSTGRES_USER'],
  password: ENV['POSTGRES_PASSWORD'],
  host: ENV['POSTGRES_HOST'],
  port: ENV['POSTGRES_PORT'],
  database: ENV['POSTGRES_DB'],
  max_connections: ENV['POSTGRES_MAX_CONNECTIONS']
}.freeze

# Global extensions
Sequel.extension :migration

# Database connection
formatter = Telegram::AppManager::Logger::SequelFormatter.new
logger = Telegram::AppManager::Logger.new('log/database.log', formatter: formatter)
DB = Sequel.connect(DB_CONNECTION_PARAMS, logger: logger)

# Database extensions
DB.extension(
  :pagination,
  :pg_json,
  :pg_array
)

# Plugins
Sequel::Model.plugin :timestamps, update_on_create: true, allow_manual_update: true
Sequel::Model.strict_param_setting = false
