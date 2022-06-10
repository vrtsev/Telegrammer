# frozen_string_literal: true

module PdrGame
  module Rounds
    class LatestResults < BaseService
      class Contract < Dry::Validation::Contract
        params do
          required(:chat_id).filled(:integer)
        end
      end

      attr_reader :winner, :loser

      def call
        check_latest_round_existance
        get_finalists
      end

      private

      def check_latest_round_existance
        return true if latest_round.present?

        raise ServiceError.new(error_code: 'PDR_GAME_NO_ROUNDS')
      end

      def get_finalists
        @winner, @loser = latest_round.winner, latest_round.loser
      end

      def latest_round
        @latest_round ||= PdrGame::Round.where(chat_id: params[:chat_id]).last
      end
    end
  end
end
