# frozen_string_literal: true

module PdrBot
  module Op
    module User
      class Find < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:user_id).filled(:integer)
          end
        end

        step :validate
        step :find_user

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_user(ctx, params:, **)
          ctx[:user] = ::PdrBot::UserRepository.new.find(params[:user_id])
        end
      end
    end
  end
end
