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

        def find_or_create_user(ctx, params:, **)
          ctx[:user] = PdrBot::UserRepository.new.find_or_create(params[:id], params)
        end

        def update_user_info(ctx, params:, **)
          PdrBot::UserRepository.new.update(params[:id], params)

          ctx[:user] = PdrBot::UserRepository.new.find(params[:id])
        end
      end
    end
  end
end
