# frozen_string_literal: true

module PdrBot
  module Op
    module GameStat
      class Decrement < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:user_id).filled(:integer)
            required(:chat_id).filled(:integer)
            required(:counter_type).filled(included_in?: PdrBot::GameStat::Counters.values)
          end
        end

        step :validate
        step :find_chat_user
        step :decrement_counter
        step :find_stat

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_chat_user(ctx, params:, **)
          ctx[:chat_user] = PdrBot::ChatUserRepository.new.find_by_chat_and_user(
            chat_id: params[:chat_id],
            user_id: params[:user_id]
          )
        end

        def decrement_counter(ctx, params:, **)
          PdrBot::GameStatRepository.new.decrement(params[:counter_type], stat_params(ctx[:chat_user]))
        end

        def find_stat(ctx, params:, **)
          ctx[:game_stat] = PdrBot::GameStatRepository.new.find_by_chat_and_user(params[:chat_id], params[:user_id])
        end

        private

        def stat_params(chat_user)
          {
            chat_id: chat_user.chat_id,
            user_id: chat_user.user_id
          }
        end
      end
    end
  end
end
