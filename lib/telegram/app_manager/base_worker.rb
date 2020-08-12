# frozen_string_literal: true

module Telegram
  module AppManager
    class BaseWorker
      include Sidekiq::Worker

      def perform
        raise "Implement method `perform` in #{self.class}"
      end

      private

      def handle_operation_errors(error, params=nil)
        error_msg = "#{self.class} has operation error: #{error} :: Params: #{params}"
        raise(error_msg)
      end
    end
  end
end
