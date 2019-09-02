ENV_FILE_NAME = '.env'

require './config/dotenv.rb'
require './config/i18n.rb'
require './config/telegram-bot.rb'
require './config/telegram_bot_manager.rb'
require './config/sidekiq.rb'

# Telegram config
Telegram::Bot::ClientStub.stub_all!

# Redis config
REDIS = MockRedis.new

# DB config
DB_CONNECTION_PARAMS = {
  adapter:    :postgres,
  user:       ENV['POSTGRES_USER'],
  password:   ENV['POSTGRES_PASSWORD'],
  host:       ENV['POSTGRES_HOST'],
  port:       ENV['POSTGRES_PORT'],
  database:   ENV['POSTGRES_DATABASE'] + '_test',
}
DB = Sequel.connect(DB_CONNECTION_PARAMS)
Sequel::Model.plugin :timestamps, update_on_create: true, allow_manual_update: true
Sequel::Model.strict_param_setting = false

# Import all support files
Dir[File.join(__dir__, 'support', '*.rb')].each { |file| require file }
