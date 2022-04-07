# frozen_string_literal: true

ENV_FILE_NAME = '.env.development'

require './config/dotenv.rb'
require './config/redis.rb'
require './config/active_record.rb'
require './config/telegram_bot.rb'
require './config/sidekiq.rb'
