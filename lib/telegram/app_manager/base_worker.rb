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
        report_app_owner(error_msg)
        raise(error_msg)
      end

      def report_app_owner(message)
        # Specify your main bot here

        # Telegram::AppManager::Message
        #   .new(Telegram.bots[:admin_bot], message)
        #   .send_to_app_owner
      end

    end
  end
end
