# frozen_string_literal: true

module ExampleBot
  module Responders
    class AutoAnswer < Telegram::AppManager::BaseResponder
      def call
        if params[:auto_answer].present?
          auto_answer_message
        else
          received_message
        end
      end

      def auto_answer_message
        message(
          params[:auto_answer],
          bot: Telegram.bots[:example_bot],
          chat_id: params[:current_chat_id]
        ).reply(message_id: params[:current_message_id])
      end

      def received_message
        message(
          received_message_notification_text,
          bot: Telegram.bots[:example_bot],
          chat_id: params[:current_chat_id]
        ).reply(message_id: params[:current_message_id])
      end

      private

      def received_message_notification_text
        I18n.t('.example_bot.actions.message', message: params[:current_message_text]).sample
      end
    end
  end
end
