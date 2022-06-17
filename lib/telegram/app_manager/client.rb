# frozen_string_literal: true

module Telegram
  module AppManager
    class Client
      TELEGRAM_FILE_BASE_URL = 'https://api.telegram.org/file'.freeze

      attr_reader :bot

      def initialize(bot)
        @bot = bot
      end

      # USERS API
      def get_bot
        request(:getMe)
      end

      # MESSAGES API
      def send_message(text:, chat_id:, **params)
        request(:sendMessage, text: text, chat_id: chat_id, **params)
      end

      def reply_message(text:, chat_id:, reply_to_message_id:, **params)
        request(:sendMessage, text: text, chat_id: chat_id, reply_to_message_id: reply_to_message_id, **params)
      end

      def edit_message(text:, chat_id:, message_id:, **params)
        request(:editMessageText, text: text, chat_id: chat_id, message_id: message_id, **params)
      end

      def delete_message(chat_id:, message_id:, **params)
        request(:deleteMessage, chat_id: chat_id, message_id: message_id, **params)
      end

      # CHATS API
      def get_chat(chat_id)
        request(:getChat, chat_id: chat_id)
      end

      def get_chat_photo
        request(:getChat, chat_id: chat_id)
      end

      def chat_photo_url(chat_id)
        chat = get_chat(chat_id)
        chat[:photo] && file_url(chat.dig(:photo, :big_file_id))
      end

      # FILES API
      def get_file(file_id)
        request(:getFile, file_id: file_id)
      end

      def file_url(file_id)
        file = get_file(file_id)
        file_path = file && file[:file_path]

        "#{TELEGRAM_FILE_BASE_URL}/bot#{bot.token}/#{file_path}"
      end

      private

      def request(action, params = nil)
        response = params.present? ? bot.request(action, params) : bot.request(action)

        if response['result'].is_a?(Hash)
          Hashie.symbolize_keys!(response['result'])
        elsif response['result'].is_a?(TrueClass)
          true
        end
      end
    end
  end
end
