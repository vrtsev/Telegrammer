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

        step Macro::Validate(:params, with: Contract)
        step :find_or_create_chat_user

        def find_or_create_chat_user(ctx, params:, **)
          ctx[:chat_user] = PdrBot::ChatUserRepository.new.find_by_chat_and_user(
            chat_id: params[:chat_id],
            user_id: params[:user_id]
          )

          ctx[:chat_user] = create_chat_user(ctx[:params]) unless ctx[:chat_user].present?
          ctx[:chat_user]
        end

        private

        def create_chat_user(chat_user_params)
          PdrBot::ChatUserRepository.new.create(chat_user_params)
        end
      end
    end
  end
end
