require_all 'apps/admin_bot/concerns'
require_all 'apps/admin_bot/actions'
require_all 'apps/admin_bot/responders'
require_relative 'controller.rb'

module AdminBot
  class Application < Telegram::AppManager::Application
    private

    def controller
      AdminBot::Controller
    end

    def handle_exception(exception)
      Telegram::AppManager::Message
        .new(Telegram.bots[:admin_bot], exception.full_message.truncate(4000))
        .send_to_app_owner

      super
    end
  end
end
