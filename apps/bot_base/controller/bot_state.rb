# frozen_string_literal: true

module BotBase
  module Controller
    module BotState
      def enable!
        bot.update!(enabled: true)
        send_message(text: 'Bot has been enabled', chat_id: Chat.for_app_owner.id)
      end

      def disable!
        bot.update!(enabled: false)
        send_message(text: 'Bot has been disabled', chat_id: Chat.for_app_owner.id)
      end

      def check_bot_state
        return true if bot_enabled?

        logger.info(Rainbow("> Bot is disabled").bold.red)
        throw :abort
      end

      private

      def bot_enabled?
        bot.enabled?
      end

      def bot
        @bot ||= Bot.find_or_create_by(name: super.id, username: super.username)
      end
    end
  end
end
