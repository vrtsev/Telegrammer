# frozen_string_literal: true

module PdrBot
  module Op
    module GameStat
      class Increment < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:user_id).filled(:integer)
            required(:chat_id).filled(:integer)
            required(:counter_type).filled(included_in?: PdrBot::GameStat::Counters.values)
          end
        end

        step :validate
        step :find_chat_user
        step :find_or_create_user_stat
        step :increment_counter

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

        def find_or_create_user_stat(ctx, params:, **)
          record = PdrBot::GameStatRepository.new.find_by_chat_and_user(
            ctx[:chat_user].chat_id,
            ctx[:chat_user].user_id
          )

          ctx[:stat] = record.present? ? record : create_stat(stat_params(ctx[:chat_user]))
        end

        def increment_counter(ctx, params:, **)
          PdrBot::GameStatRepository.new.increment(params[:counter_type], stat_params(ctx[:chat_user]))
        end

        private

        def stat_params(chat_user)
          {
            chat_id: chat_user.chat_id,
            user_id: chat_user.user_id
          }
        end

        def create_stat(params)
          PdrBot::GameStatRepository.new.create(params)
        end
      end
    end
  end
end
