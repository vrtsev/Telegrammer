# frozen_string_literal: true

module JeniaBot
  module Responders
    class CallJenia < Telegram::AppManager::Responder
      KEYBOARD_SLICE_COUNT = 1

      def call
        reply_with(:message, text: response_text, reply_markup: reply_markup)
      end

      private

      def response_text
        return params[:response] if params[:response].present?

        t('jenia_bot.default_call_answer')
      end

      def reply_markup
        {
          keyboard: sliced_questions,
          resize_keyboard: true,
          one_time_keyboard: true
        }
      end

      def sliced_questions
        params[:questions]&.each_slice(KEYBOARD_SLICE_COUNT).to_a
      end
    end
  end
end
