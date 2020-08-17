# frozen_string_literal: true

module Telegram
  module AppManager
    class ExceptionHandler
      attr_reader :exception, :payload, :action_options, :bot

      def initialize(exception, options = {})
        @exception = exception

        @payload = options[:payload]
        @action_options = options[:action_options]
        @bot = options[:bot]
      end

      def call
        puts 'Application raised exception'.bold.red
        puts exception.full_message
      end
    end
  end
end
