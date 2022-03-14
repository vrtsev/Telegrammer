# frozen_string_literal: true

module Telegram
  module AppManager
    class Application
      extend Helpers::Logging

      class << self
        def config
          @config ||= Configuration.new
        end

        def config=(config)
          @config = config
        end

        def configure
          yield(config)
        end

        def run
          logger.info "[#{config.app_name}] Application is listening messages...".bold.green
          Telegram::Bot::UpdatesPoller.start(config.telegram_bot, config.controller)
        rescue HTTPClient::ReceiveTimeoutError, OpenSSL => e
          logger.info "[#{config.app_name}] Poller timeout error. Reconnecting".bold.red
          run
        end

        private

        def app_start_message
          logger.info <<~INFO
            \n=========================================================
            Application is starting

            App name: #{config.app_name.to_s.bold.cyan}
            Telegram bot username: #{config.telegram_bot.username}
            Main controller: #{config.controller}
            Controller logging enabled: #{config.controller_logging}

            Make sure your bot has group privacy setting disabled in telegram
            to allow application to sync incoming data
            =========================================================\n
          INFO
        end
      end
    end
  end
end
