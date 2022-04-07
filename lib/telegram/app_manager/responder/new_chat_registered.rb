# frozen_string_literal: true

module Telegram
  module AppManager
    class Responder
      class NewChatRegistered < Responder
        class Contract < Telegram::AppManager::Contract
          params do
            required(:chat).filled(:hash)
          end
        end

        def call
          respond_with(:message, text: new_chat_text, chat_id: ENV['TELEGRAM_APP_OWNER_ID'])
        end

        private

        def new_chat_text
          <<~MSG
            ℹ️ New chat registered

            External ID: #{params.dig(:chat, :external_id)}
            Chat type: #{params.dig(:chat, :chat_type)}
            Name: #{chat_name}
          MSG
        end

        def chat_name
          "#{params.dig(:chat, :title)} /
            #{params.dig(:chat, :username)} /
            #{params.dig(:chat, :first_name)} /
            #{params.dig(:chat, :last_name)}"
        end
      end
    end
  end
end
