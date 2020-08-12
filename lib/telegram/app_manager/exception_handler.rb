# frozen_string_literal: true

module Telegram
  module AppManager
    class ExceptionHandler
      attr_reader :exception

      def initialize(exception)
        @exception = exception
      end

      def call
        puts 'Application raised exception'.bold.red
        puts exception.full_message
      end
    end
  end
end
