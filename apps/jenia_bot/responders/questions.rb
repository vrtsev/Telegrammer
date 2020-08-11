# frozen_string_literal: true

module JeniaBot
  module Responders
    class Questions < Telegram::AppManager::BaseResponder
      KEYBOARD_SLICE_COUNT = 1

      def call
        send_message(
          text,
          bot: Telegram.bots[:jenia_bot],
          chat_id: params[:current_chat_id],
          reply_markup: markup(sliced_questions)
        )
      end

      private

      def text
        I18n.t('.jenia_bot.trigger_answer').sample
      end

      def sliced_questions
        params[:questions].each_slice(KEYBOARD_SLICE_COUNT).to_a
      end

      def markup(questions)
        {
          keyboard: questions,
          resize_keyboard: true,
          one_time_keyboard: true
        }
      end
    end
  end
end
