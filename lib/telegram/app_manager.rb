# frozen_string_literal: false

require 'telegram/bot'
require 'dry-validation'
require 'logger'

# Require main dependencies
require_relative 'app_manager/helpers/responding.rb'
require_relative 'app_manager/helpers/logging.rb'
require_relative 'app_manager/helpers/validation.rb'

require_relative 'app_manager/configuration.rb'
require_relative 'app_manager/application.rb'
require_relative 'app_manager/service.rb'
require_relative 'app_manager/worker.rb'

require_relative 'app_manager/logger/multi_io.rb'
require_relative 'app_manager/logger/default_formatter.rb'
require_relative 'app_manager/logger/active_record_formatter.rb'
require_relative 'app_manager/logger.rb'
require_relative 'app_manager/log_subscriber.rb'

require_relative 'app_manager/builder.rb'
require_relative 'app_manager/builders/chat_user.rb'
require_relative 'app_manager/builders/chat.rb'
require_relative 'app_manager/builders/message.rb'
require_relative 'app_manager/builders/user.rb'
module Telegram
  module AppManager
    class << self
      delegate :app_name,
               :telegram_bot,
               :controller,
               :controller_action_logging,
               :environment,
               to: :config

      def config
        @config ||= Configuration.new
      end

      def config=(config)
        @config = config
      end

      def logger
        config.logger || AppManager::Logger.new("log/#{config.app_name.underscore}.log")
      end
    end
  end
end
