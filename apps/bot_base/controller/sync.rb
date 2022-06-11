# frozen_string_literal: true

module BotBase
  module Controller
    module Sync
      private

      attr_reader :current_chat,
                  :current_user,
                  :current_chat_user,
                  :current_message

      def sync_request
        @current_chat ||= sync_chat
        @current_user ||= sync_user
        @current_chat_user ||= sync_chat_user
        @current_message ||= sync_message
      end

      def sync_chat
        Chats::Sync.call(
          payload: payload['chat'],
          autoapprove: bot_setting.autoapprove_chat,
          bot: bot.id
        ).chat
      end

      def sync_user(user_payload = nil)
        user_payload ||= payload['from']

        Users::Sync.call(payload: user_payload).user
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
          bot: bot.id
        ).message
      end
    end
  end
end
