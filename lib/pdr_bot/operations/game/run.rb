module PdrBot
  module Op
    module Game
      class Run < Telegram::AppManager::BaseOperation
        MINIMUM_USER_COUNT = 2

        pass :find_last_game_round
        step :game_allowed?
        step :check_minimum_user_count

        step :select_loser
        step :select_winner

        step :save_game_round
        step :increment_winner_stats
        step :increment_loser_stats

        def find_last_game_round(ctx, **)
          ctx[:last_round] = PdrBot::GameRoundRepository.new.find_latest_by_chat_id(ctx[:chat].id)
        end

        def game_allowed?(ctx, **)
          return true if ctx[:last_round].nil?
          return true if Date.today.to_time.day > ctx[:last_round].created_at.to_date.day

          operation_error(ctx, PdrBot.localizer.pick('game.not_allowed'))
        end

        def check_minimum_user_count(ctx, **)
          users_count = PdrBot::ChatUserRepository.new.users_count_by_chat_id(ctx[:chat].id) 
          return true if users_count >= MINIMUM_USER_COUNT

          operation_error(ctx, PdrBot.localizer.pick('game.not_enough_users', min_count: MINIMUM_USER_COUNT))
        end

        def select_loser(ctx, **)
          chat_user = PdrBot::ChatUserRepository.new.random_by_chat(ctx[:chat].id)
          ctx[:loser] = PdrBot::UserRepository.new.find(chat_user.user_id)
        end

        def select_winner(ctx, **)
          chat_user = PdrBot::ChatUserRepository.new.random_by_chat(ctx[:chat].id, except_user_id: ctx[:loser].id)
          ctx[:winner] = PdrBot::UserRepository.new.find(chat_user.user_id)
        end

        def save_game_round(ctx, **)
          ctx[:game_round] = PdrBot::GameRoundRepository.new.create(
            chat_id: ctx[:chat].id,
            initiator_id: ctx[:user].id,
            winner_id: ctx[:winner].id,
            loser_id: ctx[:loser].id
          )
        end

        def increment_winner_stats(ctx, **)
          result = PdrBot::Op::Stat::Increment.call(chat: ctx[:chat], params: {
            user_id: ctx[:winner].id,
            chat_id: ctx[:chat].id,
            counter: PdrBot::Stat::Counters.winner
          })

          ctx[:winner_stat] = result[:stat] if result.success?
        end

        def increment_loser_stats(ctx, **)
          result = PdrBot::Op::Stat::Increment.call(chat: ctx[:chat], params: {
            user_id: ctx[:loser].id,
            chat_id: ctx[:chat].id,
            counter: PdrBot::Stat::Counters.loser
          })

          ctx[:loser_stat] = result[:stat] if result.success?
        end

      end
    end
  end
end
