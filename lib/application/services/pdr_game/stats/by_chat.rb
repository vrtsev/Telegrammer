# frozen_string_literal: true

module PdrGame
  module Stats
    class ByChat < Telegram::AppManager::Service
      class Contract < Dry::Validation::Contract
        params do
          required(:chat_id).filled(:integer)
        end
      end

      attr_reader :chat_stats, :winner_leader_stat, :loser_leader_stat

      def call
        check_stats_existance
        find_winner_leader_stat
        find_loser_leader_stat
      end

      private

      def check_stats_existance
        return true if stats.present?

        raise ServiceError.new(error_code: 'PDR_GAME_STATS_NOT_FOUND')
      end

      def find_winner_leader_stat
        @winner_leader_stat = stats.order(winner_count: :desc).first
      end

      def find_loser_leader_stat
        @loser_leader_stat = stats.order(loser_count: :desc).first
      end

      def stats
        @chat_stats ||= PdrGame::Stat
          .joins(:chat_user)
          .where(chat_users: { chat_id: params[:chat_id], deleted_at: nil })
      end
    end
  end
end
