# frozen_string_literal: true

module PdrBot
  module Responders
    class Game < Telegram::AppManager::BaseResponder
      def call
        send_message(game_start_message, bot: Telegram.bots[:pdr_bot], chat_id: params[:current_chat_id])
        sleep(rand(0..3))
        send_message(searching_users_message, bot: Telegram.bots[:pdr_bot], chat_id: params[:current_chat_id])
      end

      def game_start_message
        ::PdrBot.localizer.pick('game.start_title')
      end

      def searching_users_message
        ::PdrBot.localizer.pick('game.searching_users')
      end
    end
  end
end
