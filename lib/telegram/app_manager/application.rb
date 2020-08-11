# frozen_string_literal: true

module Telegram
  module AppManager
    class Application
      def initialize(configuration)
        @configuration = configuration

        before_run
        app_start_message if AppManager.configuration.show_app_start_message
      end

      def before_run
      rescue StandardError => exception
        handle_exception(exception)
      end

      def run
        puts "[#{@configuration.app_name}] Application is listening messages...".bold.green

        Telegram::Bot::UpdatesPoller.start(
          @configuration.bot,
          controller
        )
      rescue HTTPClient::ReceiveTimeoutError
        puts "[#{@configuration.app_name}] Poller timeout error. Reconnecting"
        run
      rescue StandardError => e
        handle_exception(e)
      end

      private

      def controller
        raise "Implement method #{__method__} in your app file"
      end

      def app_start_message
        puts <<~INFO
          =========================================================
          Application is initialized and configured

          App name: #{@configuration.app_name.to_s.bold.cyan}
          Telegram bot username: #{@configuration.bot.username}
          Default locale: #{@configuration.default_locale}
          =========================================================\n
        INFO
      end

      def handle_exception(exception)
        puts "[#{@configuration.app_name}] Application raised exception...".bold.red
        raise exception
      end
    end
  end
end
