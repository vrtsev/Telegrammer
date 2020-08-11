# frozen_string_literal: true

module Telegram
  module AppManager
    class BaseResponder
      attr_reader :params

      def initialize(**params)
        @params = params
      end

      private

      def edit_message(text, bot:, chat_id:, message_id:, **params)
        Telegram::AppManager::Message.new(bot, text).edit(
          message_id: message_id,
          chat_id: chat_id,
          reply_markup: params[:reply_markup]
        )
      end

      def send_message(text, bot:, chat_id:, **params)
        Telegram::AppManager::Message.new(bot, text).send_to_chat(chat_id, params)
      end

      def reply_message(text, bot:, chat_id:, message_id:)
        Telegram::AppManager::Message.new(bot, text).reply(
          to_message_id: message_id,
          chat_id: chat_id
        )
      end

      def callback_data(**params)
        Telegram::AppManager::CallbackQuery.new(params).build
      end
    end
  end
end
