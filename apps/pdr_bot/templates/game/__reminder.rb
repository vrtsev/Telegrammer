# frozen_string_literal: true

module PdrBot
  module Templates
    module Game
      class Reminder < ApplicationTemplate
        def text
          t('pdr_bot.game.reminder')
        end

        def chat_id
          params[:chat_id]
        end
      end
    end
  end
end
