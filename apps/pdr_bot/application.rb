require_all 'apps/pdr_bot/concerns'
require_all 'apps/pdr_bot/responders'
require_relative 'exception_handler.rb'
require_relative 'controller.rb'

module PdrBot
  class Application < Telegram::AppManager::Application
    private

    def controller
      PdrBot::Controller
    end
  end
end
