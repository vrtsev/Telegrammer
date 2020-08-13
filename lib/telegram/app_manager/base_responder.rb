# frozen_string_literal: true

module Telegram
  module AppManager
    class BaseResponder
      attr_reader :params

      def initialize(**params)
        @params = params
      end

      private

      def message(text, chat_id:, bot:, reply_markup: nil)
        Telegram::AppManager::Message.new(
          text,
          chat_id: chat_id,
          bot: bot,
          reply_markup: reply_markup
        )
      end
    end
  end
end
