# frozen_string_literal: true

module PdrBot
  module Op
    module User
      class Sync < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:id).filled(:integer)
            optional(:first_name).filled(:string)
            optional(:last_name).filled(:string)
            optional(:username).filled(:string)
          end
        end

        step Macro::Validate(:params, with: Contract)
        step :find_or_create_user
        step :update_user_info
        step :sync_chat_user

        def find_or_create_user(ctx, params:, **)
          ctx[:user] = PdrBot::UserRepository.new.find_or_create(params[:id], params)
          ctx[:user] = create_new_user(ctx[:params]) unless ctx[:user]
          ctx[:user]
        end

        def update_user_info(ctx, params:, **)
          PdrBot::UserRepository.new.update(params[:id], params)

          ctx[:user] = PdrBot::UserRepository.new.find(params[:id])
        end

        def sync_chat_user(ctx, params:, **)
          result = ::PdrBot::Op::ChatUser::Sync.call(
            params: { chat_id: ctx[:chat_id], user_id: ctx[:user].id }
          )

          ctx[:chat_user] = result[:chat_user]
        end

        private

        def create_new_user(user_params)
          PdrBot::UserRepository.new.create(user_params)
        end
      end
    end
  end
end
