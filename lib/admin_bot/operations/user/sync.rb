# frozen_string_literal: true

module AdminBot
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

        step :validate
        step :find_or_create_user
        step :update_user_info

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_or_create_user(ctx, params:, **)
          ctx[:user] = AdminBot::UserRepository.new.find_or_create(
            params[:id],
            user_params(params).merge(otp_secret: ROTP::Base32.random_base32)
          )
        end

        def update_user_info(ctx, params:, **)
          AdminBot::UserRepository.new.update(params[:id], user_params(params))

          ctx[:user] = AdminBot::UserRepository.new.find(params[:id])
        end

        private

        def user_params(params)
          {
            id: params[:id],
            role: AdminBot::User::Roles.not_approved,
            username: params[:username],
            first_name: params[:first_name],
            last_name: params[:last_name]
          }
        end
      end
    end
  end
end
