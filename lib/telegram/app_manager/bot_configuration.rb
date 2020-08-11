# frozen_string_literal: true

module Telegram
  module AppManager
    class BotConfiguration

      attr_accessor \
        :app_name,
        :default_locale,
        :bot,
        :logger

      def initialize
        @app_name = nil
        @default_locale = nil
        @logger = BotLogger.new(@app_name)
        @bot = nil
      end

    end
  end
end
