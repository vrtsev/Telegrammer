require 'telegram/bot'
require 'colorize'

# Require main dependencies
require_relative "app_manager/configuration.rb"
require_relative "app_manager/bot/configuration.rb"
require_relative "app_manager/logger.rb"
require_relative "app_manager/message.rb"
require_relative "app_manager/application.rb"
require_relative "app_manager/callback_query.rb"
require_relative "app_manager/exception_handler.rb"
require_relative "app_manager/controller.rb"
require_relative "app_manager/bot/class_methods.rb"

require_relative "app_manager/logger/sequel_formatter.rb"
require_relative "app_manager/base_operation.rb"
require_relative "app_manager/base_responder.rb"
require_relative "app_manager/base_repository.rb"
require_relative "app_manager/base_worker.rb"

require_all('./lib/telegram/app_manager/base_models')
require_all('./lib/telegram/app_manager/base_repositories')

module Telegram
  module AppManager
    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end
