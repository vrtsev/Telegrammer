# frozen_string_literal: true

module PdrBot
  module Responders
    class Results < Telegram::AppManager::BaseResponder
      def call
        message(results_message, bot: Telegram.bots[:pdr_bot], chat_id: params[:current_chat_id]).send
      end

      def results_message
        <<~MESSAGE
          #{title}

          #{winner_leader}
          #{loser_leader}
        MESSAGE
      end

      private

      def title
        I18n.t('.pdr_bot.latest_results.results.title').sample
      end

      def winner_leader
        I18n.t('.pdr_bot.latest_results.results.loser', user: params[:loser_full_name]).sample
      end

      def loser_leader
        I18n.t('.pdr_bot.latest_results.results.winner', user: params[:winner_full_name]).sample
      end
    end
  end
end
