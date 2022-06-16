# frozen_string_literal: true

module PdrGame
  module Rounds
    class Rollback < BaseService
      class Contract < Dry::Validation::Contract
        params do
          required(:chat_id).filled(:integer)
          required(:pdr_game_round_id).filled(:integer)
        end
      end


      def call
        ActiveRecord::Base.transaction do
          rollback_winner_counter
          rollback_loser_counter

          delete_round
        end
      end

      private

      def rollback_winner_counter
        chat_user = chat.chat_users.find_by(user_id: pdr_game_round.winner_id)
        chat_user.pdr_game_stat.decrement(:winner_count).save!
      end

      def rollback_loser_counter
        chat_user = chat.chat_users.find_by(user_id: pdr_game_round.loser_id)
        chat_user.pdr_game_stat.decrement(:loser_count).save!
      end

      def delete_round
        pdr_game_round.destroy!
      end

      def pdr_game_round
        @pdr_game_round ||= @chat.pdr_game_rounds.find(params[:pdr_game_round_id])
      end

      def chat
        @chat ||= Chat.find(params[:id])
      end
    end
  end
end
