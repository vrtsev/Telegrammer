require_all 'apps/example_bot/concerns'
require_all 'apps/example_bot/responders'
require_relative 'controller.rb'

module ExampleBot
  class Application < Telegram::AppManager::Application
    private

    def controller
      ExampleBot::Controller
    end

    def handle_exception(exception)
      Telegram::AppManager::Message
        .new(Telegram.bots[:admin_bot], exception.full_message.truncate(4000))
        .send_to_app_owner

      super
    end
  end
end
