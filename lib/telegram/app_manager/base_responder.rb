# frozen_string_literal: true

module Telegram
  module AppManager
    class BaseResponder
      attr_reader :params

      def initialize(**params)
        @params = params
      end

      private

      def send_message(text, bot:, chat_id:, reply_markup:)
        Telegram::BotManager::Message.new(bot, text).send_to_chat(chat_id, reply_markup)
      end

      def reply_message(text, bot:, chat_id:, message_id:)
        Telegram::BotManager::Message.new(bot, text).reply(
          to_message_id: message_id,
          chat_id: chat_id
        )
      end

      def callback_data(**params)
        Telegram::BotManager::CallbackQuery.new(params).build
      end
    end
  end
end
