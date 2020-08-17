# frozen_string_literal: true

module AdminBot
  module Op
    module User
      class Authenticate < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:user_id).filled(:integer)
          end
        end

        step :validate
        step :find_user
        step :admin?

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_user(ctx, params:, **)
          ctx[:user] = AdminBot::UserRepository.new.find(params[:user_id])
        end

        def admin?(ctx, **)
          ctx[:approved] = ctx[:user].role == ::AdminBot::User::Roles.not_approved
        end
      end
    end
  end
end
