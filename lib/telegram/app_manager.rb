# frozen_string_literal: false

require 'telegram/bot'
require 'colorize'
require 'dry-validation'
require 'logger'

# Require main dependencies
require_relative 'app_manager/helpers/responding.rb'
require_relative 'app_manager/helpers/logging.rb'
require_relative 'app_manager/helpers/validation.rb'

require_relative 'app_manager/configuration.rb'
require_relative 'app_manager/application.rb'
require_relative 'app_manager/contract.rb'
require_relative 'app_manager/service.rb'
require_relative 'app_manager/worker.rb'

require_relative 'app_manager/logger/helpers.rb'
require_relative 'app_manager/logger/multi_io.rb'
require_relative 'app_manager/logger/default_formatter.rb'
require_relative 'app_manager/logger/active_record_formatter.rb'
require_relative 'app_manager/logger.rb'

require_relative 'app_manager/builder.rb'
require_relative 'app_manager/builders/chat_user.rb'
require_relative 'app_manager/builders/chat.rb'
require_relative 'app_manager/builders/message.rb'
require_relative 'app_manager/builders/user.rb'

require_relative 'app_manager/responder/exception_report.rb'
require_relative 'app_manager/responder/new_chat_registered.rb'
require_relative 'app_manager/responder.rb'

require_relative 'app_manager/controller/actions.rb'
require_relative 'app_manager/controller/callbacks.rb'
require_relative 'app_manager/controller.rb'

module Telegram
  module AppManager; end
end
