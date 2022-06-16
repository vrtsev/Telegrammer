# frozen_string_literal: true

module BotBase
  module Controller
    module Sync
      attr_reader :current_chat,
                  :current_user,
                  :current_chat_user,
                  :current_message,
                  :bot_user,
                  :bot_chat_user

      def sync_request
        @current_chat ||= sync_chat
        @current_user ||= sync_user
        @current_chat_user ||= sync_chat_user
        @current_message ||= sync_message
      end

      def sync_bot
        bot_payload = Telegram::AppManager::Client.new(bot.client).get_bot

        @bot_user ||= sync_user(bot_payload, bot_id: bot.id)
        @bot_chat_user ||= sync_chat_user(chat_id: current_chat.id, user_id: @bot_user.id)
      end

      private

      def sync_chat
        Chats::Sync.call(
          payload: payload['chat'],
          autoapprove: bot.autoapprove_chat,
          bot_id: bot.id
        ).chat
      end

      def sync_user(user_payload = nil, bot_id: nil)
        user_payload ||= payload['from']

        Users::Sync.call(bot_id: bot_id, payload: user_payload).user
      end

      def sync_chat_user(chat_user_payload = nil)
        chat_user_payload ||= { chat_id: current_chat.id, user_id: current_user.id }

        ChatUsers::Sync.call(chat_user_payload).chat_user
      end

      def sync_message
        return if payload['message_id'].blank?

        Messages::Sync.call(
          payload: payload,
          chat_user_id: current_chat_user.id,
          bot_id: bot.id
        ).message
      end
    end
  end
end
