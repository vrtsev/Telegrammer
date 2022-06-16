# frozen_string_literal: true

module BotBase
  module Controller
    module Authorization
      def authorize_chat
        return true if current_chat.approved?

        reply_message(text: 'This chat is not approved to use this bot')
        logger.warn(Rainbow("> Chat is not authorized").bold.red)
        throw :abort
      end

      def authorize_admin
        return true if current_user.external_id == Integer(ENV['TELEGRAM_APP_OWNER_ID'])

        reply_message(text: 'You do not have enough rights to perform this action')
        logger.warn(Rainbow("> User is not authorized").bold.red)
        throw :abort
      end
    end
  end
end
