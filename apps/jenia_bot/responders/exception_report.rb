# frozen_string_literal: true

module JeniaBot
  module Responders
    class ExceptionReport < Telegram::AppManager::BaseResponder
      def call
        send_message(
          text,
          bot: Telegram.bots[:admin_bot],
          chat_id: ENV['TELEGRAM_APP_OWNER_ID']
        )
      end

      private

      def text
        <<~MSG
          EXCEPTION from #{JeniaBot.app_name}

          #{params[:class]}: #{params[:message]}
          #{params[:backtrace].first}
        MSG
      end
    end
  end
end
