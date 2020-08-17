# frozen_string_literal: true

module AdminBot
  module Op
    module JeniaBot
      module Question
        class Create < Telegram::AppManager::BaseOperation
          class Contract < Dry::Validation::Contract
            params do
              required(:chat_id).filled(:integer)
              required(:text).filled(:string)
            end
          end

          # step Macro::Validate(:params, with: Contract)
          step :create

          def create(ctx, params:, **)
            ctx[:question] = ::JeniaBot::Question.create(params)
          end
        end
      end
    end
  end
end
