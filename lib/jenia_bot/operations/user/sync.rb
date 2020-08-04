# frozen_string_literal: true

module JeniaBot
  module Op
    module User
      class Sync < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:chat_id).filled(:integer)

            # User params
            required(:id).filled(:integer)
            optional(:first_name).filled(:string)
            optional(:last_name).filled(:string)
            optional(:username).filled(:string)
          end
        end

        step :validate
        step :find_or_create_user
        step :assign_user_to_chat

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_or_create_user(ctx, params:, **)
          ctx[:user] = JeniaBot::UserRepository.new.find_or_create(params[:id], user_params(params))
        end

        def update_user_info(ctx, params:, **)
          Jenia::UserRepository.new.update(params[:id], user_params(params))

          ctx[:user] = Jenia::UserRepository.new.find(params[:id])
        end

        private

        def user_params(params)
          {
            id: params[:id],
            username: params[:username],
            first_name: params[:first_name],
            last_name: params[:last_name],
            otp_secret: nil # TODO: Implement OTP generation
          }
        end
      end
    end
  end
end
