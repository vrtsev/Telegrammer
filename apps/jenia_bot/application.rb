require_all 'apps/jenia_bot/concerns'
require_all 'apps/jenia_bot/responders'
require_relative 'controller.rb'

module JeniaBot
  class Application < Telegram::AppManager::Application
    private

    def controller
      JeniaBot::Controller
    end
  end
end
