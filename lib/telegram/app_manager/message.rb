# frozen_string_literal: true

module Telegram
  module AppManager
    class Message
      class Contract < Dry::Validation::Contract
        params do
          required(:text).filled(:string)
          required(:chat_id).filled(:integer)
          required(:bot).filled
        end
      end

      class ValidationError < StandardError; end

      attr_reader :text, :chat_id, :bot, :reply_markup

      def initialize(text, chat_id:, bot:, reply_markup: nil)
        @text = text
        @chat_id = chat_id
        @bot = bot
        @reply_markup = reply_markup

        validate
      end

      def validate
        result = Contract.new.call(
          text: text,
          chat_id: chat_id,
          bot: bot
        )
        raise ValidationError, result.errors.to_h unless result.success?

        true
      end

      def send
        bot.send_message(
          text: text,
          chat_id: chat_id
        )
      end

      def reply(message_id:)
        bot.public_send(
          'send_message',
          text: text,
          chat_id: chat_id,
          reply_to_message_id: message_id
        )
      end

      def edit(message_id:)
        bot.public_send(
          'edit_message_text',
          text: text,
          chat_id: chat_id,
          message_id: message_id
        )
      end

      def edit_inline(message_id:)
        bot.public_send(
          'edit_message_text',
          text: text,
          inline_message_id: message_id
        )
      end
    end
  end
end
