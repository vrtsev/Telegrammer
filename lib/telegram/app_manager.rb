require 'telegram/bot'
require 'colorize'
require 'dry-validation'
require 'logger'

# Require main dependencies
require_relative "app_manager/configuration.rb"
require_relative "app_manager/bot/configuration.rb"
require_relative "app_manager/logger.rb"
require_relative "app_manager/logger/multi_io.rb"
require_relative "app_manager/logger/sequel_formatter.rb"
require_relative "app_manager/message.rb"
require_relative "app_manager/application.rb"
require_relative "app_manager/callback_query.rb"
require_relative "app_manager/exception_handler.rb"
require_relative "app_manager/controller.rb"
require_relative "app_manager/bot/class_methods.rb"

require_relative "app_manager/base_operation.rb"
require_relative "app_manager/base_responder.rb"
require_relative "app_manager/base_repository.rb"
require_relative "app_manager/base_worker.rb"

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
