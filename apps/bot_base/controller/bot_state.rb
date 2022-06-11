# frozen_string_literal: true

module BotBase
  module Controller
    module BotState
      def enable!
        bot_setting.update!(enabled: true)
        send_message(text: 'Bot has been enabled', chat_id: Chat.for_app_owner.id)
      end

      def disable!
        bot_setting.update!(enabled: false)
        send_message(text: 'Bot has been disabled', chat_id: Chat.for_app_owner.id)
      end

      private

      def check_bot_state
        return if bot_enabled?

        logger.info(Rainbow("> Bot is disabled").bold.red)
        throw :abort unless action_name == 'enable!'
      end

      def bot_enabled?
        bot_setting.enabled?
      end

      def bot_setting
        @bot_setting ||= BotSetting.find_or_create_by(bot: bot.username)
      end
    end
  end
end
