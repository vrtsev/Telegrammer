module PdrBot
  module Op
    module GameRound
      class LatestResults < Telegram::AppManager::BaseOperation

        step :find_last_game_round
        step :find_loser
        step :find_winner

        def find_last_game_round(ctx, **)
          ctx[:last_round] = ::PdrBot::GameRoundRepository.new.find_latest_by_chat_id(ctx[:chat].id)
          ctx[:last_round].present? ? true : operation_error(ctx, PdrBot.localizer.pick('latest_results.results_not_found'))
        end

        def find_loser(ctx, **)
          ctx[:loser] = PdrBot::UserRepository.new.find(ctx[:last_round].loser_id)
        end

        def find_winner(ctx, **)
          ctx[:winner] = PdrBot::UserRepository.new.find(ctx[:last_round].winner_id)
        end

      end
    end
  end
end
