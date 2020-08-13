# frozen_string_literal: true

module Telegram
  module AppManager
    class Configuration
      attr_accessor \
        :controller_logging,
        :show_app_start_message,

      def initialize
        @controller_logging = true
        @show_app_start_message = true
      end
    end
  end
end
