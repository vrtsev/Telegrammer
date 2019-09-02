require_all 'apps/my_bot/concerns'
require_all 'apps/my_bot/views'
require_relative 'controller.rb'

module MyBot
  class Application < Telegram::BotManager::Application

    def configure
      # Configure your app here
      super
    end

    private

    def controller
      MyBot::Controller
    end

    def configuration_message
      # Change config message here
      super
    end

    def startup_message
      # Change startup message here
      super
    end

    def handle_exception(exception)
      # Any exceptions handlers here
      super
    end

  end
end
