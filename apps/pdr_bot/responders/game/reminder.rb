# frozen_string_literal: true

module PdrBot
  module Responders
    module Game
      class Reminder < Telegram::AppManager::Responder
        def call
          respond_with(:message, text: text, chat_id: params[:chat_id])
        end

        private

        def text
          t('pdr_bot.game.reminder')
        end
      end
    end
  end
end
