require_all 'apps/pdr_bot/concerns'
require_all 'apps/pdr_bot/responders'
require_relative 'controller.rb'

module PdrBot
  class Application < Telegram::BotManager::Application

    def configure
      # Configure your app here
      super
    end

    def run
      super
    rescue HTTPClient::ReceiveTimeoutError => exception
      puts "Poller timeout error. Reconnecting"
      run
    end

    private

    def controller
      PdrBot::Controller
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
      puts "[#{@configuration.app_name}] Application raised exception...".bold.red
      Telegram::BotManager::Message
        .new(Telegram.bots[:admin_bot], exception.full_message.truncate(4000))
        .send_to_app_owner
      raise exception
    end

  end
end
