# frozen_string_literal: true

module AdminBot
  module Op
    module JeniaBot
      module AutoAnswer
        class Create < Telegram::AppManager::BaseOperation
          class Contract < Dry::Validation::Contract
            params do
              required(:author_id).filled(:integer)
              required(:chat_id).filled(:integer)
              required(:trigger).filled(:string)
              required(:answer).filled(:string)
              required(:approved).filled(:bool)
            end
          end

          DEFAULT_APPROVE_STATE = true

          step :validate
          step :create

          def validate(ctx, params:, **)
            ctx[:validation_result] = Contract.new.call(params)
            ctx[:params] = ctx[:validation_result].to_h

            handle_validation_errors(ctx)
          end

          def create(ctx, params:, **)
            ctx[:auto_answer] = ::JeniaBot::AutoAnswer.create(auto_answer_params(params))
          end

          private

          def auto_answer_params(params)
            {
              author_id: params[:author_id],
              chat_id: params[:chat_id],
              approved: params[:approved] || DEFAULT_APPROVE_STATE,
              trigger: params[:trigger],
              answer: params[:answer]
            }
          end
        end
      end
    end
  end
end
