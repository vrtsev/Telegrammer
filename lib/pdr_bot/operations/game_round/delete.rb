# frozen_string_literal: true

module PdrBot
  module Op
    module GameRound
      class Delete < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:game_round_id).filled(:integer)
          end
        end

        step :validate
        step :delete_game_round

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def delete_game_round(ctx, params:, **)
          ctx[:game_round] = PdrBot::GameRoundRepository.new.delete(params[:game_round_id])
        end
      end
    end
  end
end
