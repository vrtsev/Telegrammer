# frozen_string_literal: true

module Telegram
  module AppManager
    class Responder
      class ExceptionReport < Responder
        class Contract < Dry::Validation::Contract
          params do
            required(:exception).filled
            required(:payload).filled(:hash)
          end
        end

        def call
          respond_with(:message, text: exception_text, chat_id: ENV['TELEGRAM_APP_OWNER_ID'])
        end

        private

        def exception_text
          <<~MSG
            ⚠️ EXCEPTION REPORT

            Chat: #{params[:payload][:chat]}
            User: #{params[:payload][:from]}
            Text: (##{params[:payload][:message_id]}) '#{params[:payload][:text]}'

            #{params[:exception].class}: #{params[:exception].message}
            #{params[:exception].backtrace.first}
          MSG
        end
      end
    end
  end
end
