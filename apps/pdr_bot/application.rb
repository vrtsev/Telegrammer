require_all 'apps/pdr_bot/concerns'
require_all 'apps/pdr_bot/responders'
require_relative 'controller.rb'

module PdrBot
  class Application < Telegram::AppManager::Application
    private

    def controller
      PdrBot::Controller
    end

    def handle_exception(exception)
      Telegram::AppManager::Message
        .new(Telegram.bots[:admin_bot], exception.full_message.truncate(4000))
        .send_to_app_owner

      super
    end
  end
end
