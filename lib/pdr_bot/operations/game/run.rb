# frozen_string_literal: true

module PdrBot
  module Op
    module Game
      class Run < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:chat_id).filled(:integer)
            required(:user_id).filled(:integer)
          end
        end

        MINIMUM_USER_COUNT = 2

        step :validate

        pass :find_last_game_round
        step :game_allowed?
        step :check_minimum_user_count

        step :select_loser
        step :select_winner

        step :save_game_round
        step :increment_winner_stats
        step :increment_loser_stats

        fail :rollback_game_round
        fail :rollback_winner_stat
        fail :rollback_loser_stat
        fail :fail_operation

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_last_game_round(ctx, params:, **)
          ctx[:last_round] = PdrBot::GameRoundRepository.new.find_latest_by_chat_id(params[:chat_id])
        end

        def game_allowed?(ctx, params:, **)
          return true if ctx[:last_round].nil?
          return true if Date.today.day != ctx[:last_round].created_at.day

          operation_error(ctx, I18n.t('.pdr_bot.game.not_allowed').sample)
        end

        def check_minimum_user_count(ctx, params:, **)
          users_count = PdrBot::ChatUserRepository.new.users_count_by_chat_id(params[:chat_id])
          return true if users_count >= MINIMUM_USER_COUNT

          operation_error(ctx, I18n.t('.pdr_bot.game.not_enough_users', min_count: MINIMUM_USER_COUNT).sample)
        end

        def select_loser(ctx, params:, **)
          chat_user = PdrBot::ChatUserRepository.new.random_by_chat(params[:chat_id])
          ctx[:loser] = PdrBot::UserRepository.new.find(chat_user.user_id)
        end

        def select_winner(ctx, params:, **)
          chat_user = PdrBot::ChatUserRepository.new.random_by_chat(params[:chat_id], except_user_id: ctx[:loser].id)
          ctx[:winner] = PdrBot::UserRepository.new.find(chat_user.user_id)
        end

        def save_game_round(ctx, params:, **)
          result = PdrBot::Op::GameRound::Create.call(
            params: {
              chat_id: params[:chat_id],
              initiator_id: params[:user_id],
              winner_id: ctx[:winner].id,
              loser_id: ctx[:loser].id
            }
          )

          ctx[:game_round] = result[:game_round] if result.success?
        end

        def increment_winner_stats(ctx, params:, **)
          result = PdrBot::Op::GameStat::Increment.call(
            params: {
              user_id: ctx[:winner].id,
              chat_id: params[:chat_id],
              counter_type: PdrBot::GameStat::Counters.winner
            }
          )

          ctx[:winner_stat] = result[:stat] if result.success?
        end

        def increment_loser_stats(ctx, params:, **)
          result = PdrBot::Op::GameStat::Increment.call(
            params: {
              user_id: ctx[:loser].id,
              chat_id: params[:chat_id],
              counter_type: PdrBot::GameStat::Counters.loser
            }
          )

          ctx[:loser_stat] = result[:stat] if result.success?
        end

        def rollback_game_round(ctx, params:, **)
          return true unless ctx[:game_round].present?

          result = PdrBot::Op::GameRound::Delete.call(params: { game_round_id: ctx[:game_round].id })
          result.success?
        end

        def rollback_winner_stat(ctx, params:, **)
          return true unless ctx[:winner_stat].present?

          result = PdrBot::Op::GameStat::Decrement.call(
            params: {
              user_id: ctx[:winner].id,
              chat_id: params[:chat_id],
              counter_type: PdrBot::GameStat::Counters.winner
            }
          )
          result.success?
        end

        def rollback_loser_stat(ctx, params:, **)
          return true unless ctx[:loser_stat].present?

          result = PdrBot::Op::GameStat::Decrement.call(
            params: {
              user_id: ctx[:loser].id,
              chat_id: params[:chat_id],
              counter: PdrBot::GameStat::Counters.loser
            }
          )
          result.success?
        end

        def fail_operation(ctx, params:, **)
          false
        end
      end
    end
  end
end
