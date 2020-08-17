# frozen_string_literal: true

module AdminBot
  module Op
    module JeniaBot
      module AutoAnswer
        class Edit < Telegram::AppManager::BaseOperation
          class Contract < Dry::Validation::Contract
            params do
              required(:auto_answer_id).filled(:integer)
              required(:trigger).filled(:string)
              required(:answer).filled(:string)
              optional(:approved).filled(:bool)
            end
          end

          step :validate
          step :find
          step :update

          def validate(ctx, params:, **)
            ctx[:validation_result] = Contract.new.call(params)
            ctx[:params] = ctx[:validation_result].to_h

            handle_validation_errors(ctx)
          end

          def find(ctx, params:, **)
            ctx[:auto_answer] = ::JeniaBot::AutoAnswerRepository.new.find(params[:auto_answer_id])
          end

          def update(ctx, params:, **)
            ::JeniaBot::AutoAnswerRepository.new.update(params[:auto_answer_id], auto_answer_params(params))
            ctx[:auto_answer] = ::JeniaBot::AutoAnswerRepository.new.find(params[:auto_answer_id])
          end

          private

          def auto_answer_params(params)
            {
              approved: params[:approved],
              trigger: params[:trigger],
              answer: params[:answer]
            }
          end
        end
      end
    end
  end
end
