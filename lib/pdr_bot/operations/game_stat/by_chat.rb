# frozen_string_literal: true

module PdrBot
  module Op
    module GameStat
      class ByChat < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:chat_id).filled(:integer)
          end
        end

        step :validate
        step :find_chat_users_stats
        step :find_winner_leader_stat
        step :find_winner_user
        step :find_loser_leader_stat
        step :find_loser_user

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_chat_users_stats(ctx, params:, **)
          ctx[:chat_stats] = PdrBot::GameStatRepository.new.find_all_by_chat_id(params[:chat_id])
          ctx[:chat_stats].present? ? true : operation_error(ctx, I18n.t('.pdr_bot.stats.not_found').sample)
        end

        def find_winner_leader_stat(ctx, params:, **)
          ctx[:winner_stat] = PdrBot::GameStatRepository.new.find_leader_by_chat_id(
            chat_id: params[:chat_id],
            counter: PdrBot::GameStat::Counters.winner
          )
        end

        def find_winner_user(ctx, params:, **)
          ctx[:winner] = PdrBot::UserRepository.new.find(ctx[:winner_stat].user_id)
        end

        def find_loser_leader_stat(ctx, params:, **)
          ctx[:loser_stat] = PdrBot::GameStatRepository.new.find_leader_by_chat_id(
            chat_id: params[:chat_id],
            counter: PdrBot::GameStat::Counters.loser,
            exclude_user_id: ctx[:winner_stat].user_id
          )
        end

        def find_loser_user(ctx, params:, **)
          ctx[:loser] = PdrBot::UserRepository.new.find(ctx[:loser_stat].user_id)
        end
      end
    end
  end
end
