# frozen_string_literal: false

require 'telegram/bot'
require 'logger'

# Require main dependencies
require_relative 'app_manager/logger/multi_io.rb'
require_relative 'app_manager/logger/default_formatter.rb'
require_relative 'app_manager/logger/active_record_formatter.rb'
require_relative 'app_manager/logger.rb'

require_relative 'app_manager/configuration.rb'
require_relative 'app_manager/application.rb'
require_relative 'app_manager/controller.rb'
require_relative 'app_manager/extensions/log_subscriber.rb'
require_relative 'app_manager/client.rb'

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
