# frozen_string_literal: true

module PdrBot
  module Responders
    class Game < Telegram::AppManager::BaseResponder
      def call
        message(game_start_message, bot: Telegram.bots[:pdr_bot], chat_id: params[:current_chat_id]).send
        sleep(rand(0..3))
        message(searching_users_message, bot: Telegram.bots[:pdr_bot], chat_id: params[:current_chat_id]).send
      end

      def game_start_message
        I18n.t('.pdr_bot.game.start_title').sample
      end

      def searching_users_message
        I18n.t('.pdr_bot.game.searching_users').sample
      end
    end
  end
end
