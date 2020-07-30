# frozen_string_literal: true

module PdrBot
  module Responders
    class Results < Telegram::AppManager::BaseResponder
      def call
        send_message(results_message, bot: Telegram.bots[:pdr_bot], chat_id: params[:current_chat_id])
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
        ::PdrBot.localizer.pick('latest_results.results.title')
      end

      def winner_leader
        ::PdrBot.localizer.pick('latest_results.results.loser', user: params[:loser_full_name])
      end

      def loser_leader
        ::PdrBot.localizer.pick('latest_results.results.winner', user: params[:winner_full_name])
      end
    end
  end
end
