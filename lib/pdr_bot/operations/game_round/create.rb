# frozen_string_literal: true

module PdrBot
  module Op
    module GameRound
      class Create < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:chat_id).filled(:integer)
            required(:initiator_id).filled(:integer)
            required(:winner_id).filled(:integer)
            required(:loser_id).filled(:integer)
          end
        end

        step :validate
        step :create_game_round

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def create_game_round(ctx, params:, **)
          ctx[:game_round] = PdrBot::GameRoundRepository.new.create(game_round_params(params))
        end

        private

        def game_round_params(params)
          {
            chat_id: params[:chat_id],
            initiator_id: params[:initiator_id],
            winner_id: params[:winner_id],
            loser_id: params[:loser_id]
          }
        end
      end
    end
  end
end
