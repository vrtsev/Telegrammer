# frozen_string_literal: true

module Telegram
  module AppManager
    class BotConfiguration

      attr_accessor \
        :app_name,
        :locale,
        :localizer,
        :bot,
        :logger

      def initialize
        @app_name = nil
        @locale = nil
        @localizer = nil
        @logger = BotLogger.new(@app_name)
        @bot = nil
      end

    end
  end
end
