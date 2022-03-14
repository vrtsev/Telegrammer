# frozen_string_literal: true

module Telegram
  module AppManager
    class Configuration
      DEFAULT_CONTROLLER_LOGING_ENABLED = true

      # TODO Add params validation here

      attr_accessor \
        :app_name,
        :telegram_bot,
        :controller,
        :controller_logging

      def initialize
        @app_name = nil
        @telegram_bot = nil
        @controller = nil
        @controller_logging = DEFAULT_CONTROLLER_LOGING_ENABLED
      end
    end
  end
end
