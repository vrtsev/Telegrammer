# frozen_string_literal: true

module Telegram
  module AppManager
    class Application
      class << self
        delegate :logger, to: AppManager

        def config
          AppManager.config
        end

        def run
          logger.info 'Application is starting...'
          config.validate!
          app_start_message
          start_updates_poller
        end

        private

        def start_updates_poller
          logger.info Rainbow("[#{AppManager.app_name}] Application is listening messages...").bold.green
          Telegram::Bot::UpdatesPoller.new(AppManager.telegram_bot, AppManager.controller, logger: logger).start
          logger.info Rainbow("[#{AppManager.app_name}] Message listener stopped").bold.red
        rescue HTTPClient::ReceiveTimeoutError, OpenSSL => e
          logger.info Rainbow("[#{AppManager.app_name}] Poller error. Reconnecting\n").bold.red
          run
        end

        def app_start_message
          logger.info <<~INFO
            \n=========================================================
            App name: #{Rainbow(AppManager.app_name.to_s).bold.cyan}
            Environment: #{AppManager.environment}
            Telegram bot username: #{AppManager.telegram_bot.username}
            Main controller: #{AppManager.controller}
            Controller logging enabled: #{AppManager.config.controller_action_logging}

            Make sure your bot has group privacy setting disabled in
            telegram to allow application to sync incoming data

            Use Ctrl-C to stop
            =========================================================
          INFO
        end
      end
    end
  end
end
