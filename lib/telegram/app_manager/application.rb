# frozen_string_literal: true

module Telegram
  module AppManager
    class Application

      def initialize(configuration)
        @configuration = configuration
        @bot = @configuration.bot

        configure
        configuration_message if AppManager.configuration.show_config_message
      end

      def configure
      rescue => exception
        handle_exception(exception)
      end

      def run
        startup_message

        Telegram::Bot::UpdatesPoller.start(
          @bot,
          controller
        )
      rescue => exception
        handle_exception(exception)
      end

      private

      def controller
        raise "Implement method #{__method__} in your app file"
      end

      def configuration_message
        puts <<~INFO
        Application is initialized and configured
        =========================================================
        Configuration

        App name: #{@configuration.app_name.to_s.bold.cyan}
        Telegram bot username: #{@configuration.bot.username}
        Locale: #{@configuration.locale}
        =========================================================\n
        INFO
      end

      def startup_message
        puts "[#{@configuration.app_name}] Application is listening messages...".bold.green
      end

      def handle_exception(exception)
        puts "[#{@configuration.app_name}] Application raised exception...".bold.red
        raise exception
      end

    end
  end
end
