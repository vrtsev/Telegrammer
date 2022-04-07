# frozen_string_literal: true

module PdrGame
  module Stats
    class Reset < Telegram::AppManager::Service
      class Contract < Telegram::AppManager::Contract
        params do
          required(:chat_id).filled(:integer)
        end
      end

      attr_reader :chat_stats

      def call
        reset_stats
      end

      private

      def reset_stats
        chat_stats.update_all(winner_count: 0, loser_count: 0)
      end

      def chat_stats
        @chat_stats ||= PdrGame::Stat
          .joins(:chat_user)
          .where(chat_users: { chat_id: params[:chat_id] })
      end
    end
  end
end
