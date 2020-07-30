# frozen_string_literal: true

module PdrBot
  module Op
    module Stat
      class Increment < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:chat_id).filled(:integer)
            required(:user_id).filled(:integer)
            required(:counter).filled(included_in?: PdrBot::Stat::Counters.values)
          end
        end

        step Macro::Validate(:params, with: Contract)
        step :find_chat_user
        step :find_or_create_user_stat
        step :increment_counter

        def find_chat_user(ctx, params:, **)
          ctx[:chat_user] = PdrBot::ChatUserRepository.new.find_by_chat_and_user(
            chat_id: params[:chat_id],
            user_id: params[:user_id]
          )
        end

        def find_or_create_user_stat(ctx, params:, **)
          record = PdrBot::StatRepository.new.find_by_chat_and_user(
            ctx[:chat_user].chat_id,
            ctx[:chat_user].user_id
          )

          ctx[:stat] = if record.present?
                         record
                       else
                         PdrBot::StatRepository.new.create(
                           chat_id: ctx[:chat_user].chat_id,
                           user_id: ctx[:chat_user].user_id
                         )
                       end
        end

        def increment_counter(ctx, params:, **)
          PdrBot::StatRepository.new.increment(
            params[:counter],
            chat_id: ctx[:chat_user].chat_id,
            user_id: ctx[:chat_user].user_id
          )
        end
      end
    end
  end
end
