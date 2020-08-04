# frozen_string_literal: true

module JeniaBot
  module Op
    module User
      class Find < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:user_id).filled(:integer)
          end
        end

        step :find_user

        def find_user(ctx, params:, **)
          ctx[:user] = ::JeniaBot::UserRepository.new.find(params[:user_id])
        end
      end
    end
  end
end
