# frozen_string_literal: true

module JeniaBot
  module Templates
    class CallJenia < ::BotBase::Templates::BaseTemplate
      class Contract < Dry::Validation::Contract
        params do
          optional(:current_chat_id).filled(:integer)
          required(:response).maybe(:string)
          required(:questions).maybe(:array)
        end
      end

      KEYBOARD_SLICE_COUNT = 1

      def text
        params[:response] || t('jenia_bot.default_call_answer')
      end

      def reply_markup
        return if params[:questions].blank?

        {
          keyboard: sliced_questions,
          resize_keyboard: true,
          one_time_keyboard: true
        }
      end

      private

      def sliced_questions
        params[:questions]&.each_slice(KEYBOARD_SLICE_COUNT).to_a
      end
    end
  end
end
