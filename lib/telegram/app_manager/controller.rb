# frozen_string_literal: true

module Telegram
  module AppManager
    class Controller < Telegram::Bot::UpdatesController
      include Telegram::Bot::UpdatesController::MessageContext
      include Telegram::Bot::UpdatesController::Session

      # DO NOT FORGET TO SET SESSION STORE IN YOUR CONTROLLER
      # TO USE METHODS LIKE 'session[:user_id] = user_id'
      # self.session_store = :redis_cache_store, { url: redis_url }

      around_action :log_action

      def initialize(bot, controller, **options)
        super(bot, controller, **options)
      rescue => exception
        rescue_with_handler(exception)
      end

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

      def rescue_with_handler(exception)
        logger.error "\nException caught...".bold.red
        logger.error exception.full_message

        raise exception
      end

      def logger
        unless Telegram::AppManager.configuration.controller_logging
          raise 'Implement logger method in controller'
        end
      end
    end
  end
end
