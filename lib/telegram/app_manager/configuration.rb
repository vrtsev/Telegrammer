# frozen_string_literal: true

module Telegram
  module AppManager
    class Configuration

      attr_accessor \
        :controller_logging,
        :show_config_message,
        :telegram_app_owner_id

      def initialize
        @controller_logging = true
        @show_config_message = true
        @telegram_app_owner_id = nil
      end

    end
  end
end
