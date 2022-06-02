# frozen_string_literal: true

module Telegram
  module AppManager
    class Controller < Telegram::Bot::UpdatesController
      include Telegram::Bot::UpdatesController::MessageContext
      include Telegram::Bot::UpdatesController::Session
      include Telegram::Bot::UpdatesController::TypedUpdate
      include Helpers::Logging
      include Helpers::Responding
      include Controller::Callbacks
      include Controller::Actions

      self.session_store = :redis_cache_store, { url: $redis_url }

      rescue_from StandardError do |exception|
        if ENV['APP_ENV'] != 'test'
          logger.error Rainbow('Application raised exception').bold.red
          logger.error exception.full_message
        end

        response(Responder::ExceptionReport, exception: exception, payload: payload.to_h)
        handle_exception(exception)
      end

      before_action :bot_enabled?,
                    :sync_chat,
                    :sync_user,
                    :sync_chat_user,
                    :on_user_left_chat,
                    :sync_message,
                    :authenticate_chat!

      attr_reader :current_chat,
                  :current_user,
                  :current_chat_user,
                  :current_message

      private

      def handle_exception(exception)
        return if ENV['APP_ENV'] == 'test'

        message = "Hint: You can handle exception in your controller by implementing '#{__method__}' private method"
        logger.error Rainbow("\n [TelegramAppManager] #{message} \n").bold
      end

      def current_application
        self.class.module_parent::Application
      end
    end
  end
end
