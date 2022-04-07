# frozen_string_literal: true

module JeniaBot
  module Responders
    class CallJenia < Telegram::AppManager::Responder
      class Contract < Telegram::AppManager::Contract
        params do
          required(:response).filled(:string)
          optional(:questions).filled(:array)
        end
      end

      KEYBOARD_SLICE_COUNT = 1

      def call
        reply_with(:message, text: params[:response], reply_markup: reply_markup)
      end

      private

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
