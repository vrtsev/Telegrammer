# frozen_string_literal: true

require_all 'apps/jenia_bot/responders'
require_all 'apps/jenia_bot/concerns'
require_relative 'exception_handler.rb'
require_relative 'controller.rb'

module JeniaBot
  class Application < Telegram::AppManager::Application
    private

    def controller
      JeniaBot::Controller
    end
  end
end
