# frozen_string_literal: true

module PdrBot
  module Op
    module GameRound
      class LatestResults < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:chat_id).filled(:integer)
          end
        end

        step :validate
        step :find_last_game_round
        step :find_loser
        step :find_winner

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_last_game_round(ctx, params:, **)
          ctx[:last_round] = ::PdrBot::GameRoundRepository.new.find_latest_by_chat_id(params[:chat_id])
          ctx[:last_round].present? ? true : operation_error(ctx, PdrBot.localizer.pick('latest_results.results_not_found'))
        end

        def find_loser(ctx, params:, **)
          ctx[:loser] = PdrBot::UserRepository.new.find(ctx[:last_round].loser_id)
        end

        def find_winner(ctx, params:, **)
          ctx[:winner] = PdrBot::UserRepository.new.find(ctx[:last_round].winner_id)
        end
      end
    end
  end
end
