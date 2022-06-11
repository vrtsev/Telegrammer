# frozen_string_literal: true

module BotBase
  module Controller
    module Authorization
      private

      def authorize_chat
        return if current_chat.approved?

        logger.info('> Chat is not approved for bot')
        throw :abort
      end

      def authorize_admin
        return true if current_user.external_id == Integer(ENV['TELEGRAM_APP_OWNER_ID'])

        reply_with(:message, text: 'You do not have enough rights to perform this action')
        logger.warn(Rainbow("> User is not authorized").bold.red)

        throw :abort
      end
    end
  end
end
