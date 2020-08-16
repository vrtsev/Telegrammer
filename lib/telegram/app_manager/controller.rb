# frozen_string_literal: true

module Telegram
  module AppManager
    class Controller < Telegram::Bot::UpdatesController
      include Telegram::Bot::UpdatesController::MessageContext
      include Telegram::Bot::UpdatesController::Session

      redis_url = "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/#{ENV['REDIS_DB']}"
      self.session_store = :redis_cache_store, { url: redis_url }

      def self.exception_handler(handler_class)
        rescue_from StandardError do |exception|
          options = {
            payload: payload,
            action_options: action_options,
            bot: bot
          }

          handler_class.new(exception, options).call
        end
      end

      exception_handler ::Telegram::AppManager::ExceptionHandler
      around_action :log_action

      private

      def log_action(&block)
        if Telegram::AppManager.configuration.controller_logging
          timer_start = Time.now

          payload_data = payload['text'] || payload['data']

          logger.info "\nProcessing '#{payload_data.to_s.bold.cyan}' from user #{from['id'].to_s.bold.magenta} for chat id #{chat['id']}"
          logger.info "* Recognized action #{self.action_name.to_s.bold.green}"
          yield
          logger.info "Processing completed in #{Time.now - timer_start} sec\n"
        else
          yield
        end
      end

      def handle_callback_failure(error, callback_name)
        error_msg = if error.present?
                      "Callback '#{callback_name}' error: #{error}"
                    else
                      "Unknown callback '#{callback_name}' error"
                    end

        raise error_msg
      end

      def logger
        raise 'Implement logger method in controller' unless Telegram::AppManager.configuration.controller_logging
      end
    end
  end
end
