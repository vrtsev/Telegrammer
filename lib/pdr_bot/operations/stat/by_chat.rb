module PdrBot
  module Op
    module Stat
      class ByChat < Telegram::AppManager::BaseOperation

        step :find_chat_users_stats
        step :find_winner_leader_stat
        step :find_winner_user
        step :find_loser_leader_stat
        step :find_loser_user

        def find_chat_users_stats(ctx, **)
          ctx[:chat_stats] = PdrBot::StatRepository.new.find_all_by_chat_id(ctx[:chat].id)
          ctx[:chat_stats].present? ? true : operation_error(ctx, PdrBot.localizer.pick('stats.not_found'))
        end

        def find_winner_leader_stat(ctx, **)
          ctx[:winner_stat] = PdrBot::StatRepository.new.find_leader_by_chat_id(
            chat_id: ctx[:chat].id,
            counter: PdrBot::Stat::Counters.winner
          )
        end

        def find_winner_user(ctx, **)
          ctx[:winner] = PdrBot::UserRepository.new.find(ctx[:winner_stat].user_id)
        end

        def find_loser_leader_stat(ctx, **)
          ctx[:loser_stat] = PdrBot::StatRepository.new.find_leader_by_chat_id(
            chat_id: ctx[:chat].id,
            counter: PdrBot::Stat::Counters.loser,
            exclude_user_id: ctx[:winner_stat].user_id
          )
        end

        def find_loser_user(ctx, **)
          ctx[:loser] = PdrBot::UserRepository.new.find(ctx[:loser_stat].user_id)
        end

      end
    end
  end
end
