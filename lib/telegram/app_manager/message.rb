# frozen_string_literal: true

module Telegram
  module AppManager
    class Message

      def initialize(bot, text)
        @bot = bot
        @text = text

        raise 'Telegram Message is blank' unless text.present?
      end

      def edit(message_id:, chat_id:, **params)
        @bot.public_send "edit_message_text", params.merge({
          text: @text,
          message_id: message_id,
          chat_id: chat_id
        })
      end

      def edit_inline(inline_message_id:, **params)
        @bot.public_send "edit_message_text", params.merge({
          text: @text,
          inline_message_id: message_id
        })
      end

      def reply(to_message_id:, chat_id:, **params)
        @bot.public_send "send_message", params.merge({
          text: @text,
          reply_to_message_id: to_message_id,
          chat_id: chat_id
        })
      end

      def send_to_chat(chat_id, **params)
        @bot.send_message params.merge({
          chat_id: chat_id,
          text: @text
        })
      end

      def send_to_app_owner(**params)
        unless AppManager.configuration.telegram_app_owner_id
          raise 'Telegram app owner id not defined. Check bot manager config'
        end

        @bot.send_message params.merge({
          chat_id: AppManager.configuration.telegram_app_owner_id,
          text: "[#{@bot.username}] " + @text
        })
      end

    end
  end
end
