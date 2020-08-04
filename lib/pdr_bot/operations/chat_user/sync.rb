# frozen_string_literal: true

module PdrBot
  module Op
    module ChatUser
      class Sync < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:chat_id).filled(:integer)
            required(:user_id).filled(:integer)
          end
        end

        step :validate
        step :find_or_create_chat_user

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_or_create_chat_user(ctx, params:, **)
          ctx[:chat_user] = PdrBot::ChatUserRepository.new.find_by_chat_and_user(chat_user_params(params))
          ctx[:chat_user] = create_chat_user(chat_user_params(params)) unless ctx[:chat_user].present?

          ctx[:chat_user]
        end

        private

        def chat_user_params(params)
          {
            user_id: params[:user_id],
            chat_id: params[:chat_id]
          }
        end

        def create_chat_user(params)
          PdrBot::ChatUserRepository.new.create(params)
        end
      end
    end
  end
end
