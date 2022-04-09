# frozen_string_literal: true

module PdrBot
  module Responders
    module Game
      class Start < Telegram::AppManager::Responder
        def call
          respond_with(:message, text: title_text, delay: rand(2..5), id: :title_text)
          respond_with(:message, text: searching_users_text, delay: rand(1..3), id: :searching_users_text)
        end

        private

        def title_text
          t('pdr_bot.game.start.title')
        end

        def searching_users_text
          t('pdr_bot.game.start.searching_users')
        end
      end
    end
  end
end
