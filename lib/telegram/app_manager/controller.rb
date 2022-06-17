# frozen_string_literal: true

module Telegram
  module AppManager
    class Controller < Telegram::Bot::UpdatesController
      rescue_from StandardError, with: :exception_handler

      private

      def exception_handler(exception)
        raise exception if AppManager.environment == 'test'

        AppManager.logger.error Rainbow('Application raised exception').bold.red
        AppManager.logger.error exception.full_message

        handle_exception(exception)
      end

      def handle_exception(exception)
        message = "Hint: You can handle exception in your controller by implementing '#{__method__}' private method"
        AppManager.logger.error Rainbow("\n [TelegramAppManager] #{message} \n").bold
      end
    end
  end
end
