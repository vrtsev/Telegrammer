# frozen_string_literal: true

module Telegram
  module AppManager
    class Controller < Telegram::Bot::UpdatesController
      rescue_from StandardError do |exception|
        if AppManager.environment != 'test'
          AppManager.logger.error Rainbow('Application raised exception').bold.red
          AppManager.logger.error exception.full_message
        end

        handle_exception(exception)
      end

      private

      def handle_exception(exception)
        return if AppManager.environment == 'test'

        message = "Hint: You can handle exception in your controller by implementing '#{__method__}' private method"
        AppManager.logger.error Rainbow("\n [TelegramAppManager] #{message} \n").bold
      end
    end
  end
end
