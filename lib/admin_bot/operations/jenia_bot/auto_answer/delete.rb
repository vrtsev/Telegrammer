# frozen_string_literal: true

module AdminBot
  module Op
    module JeniaBot
      module AutoAnswer
        class Delete < Telegram::AppManager::BaseOperation
          class Contract < Dry::Validation::Contract
            params do
              required(:auto_answer_id).filled(:integer)
            end
          end

          step :validate
          step :find
          step :delete

          def validate(ctx, params:, **)
            ctx[:validation_result] = Contract.new.call(params)
            ctx[:params] = ctx[:validation_result].to_h

            handle_validation_errors(ctx)
          end

          def find
            ctx[:auto_answer] = ::JeniaBot::AutoAnswerRepository.new.find(params[:auto_answer_id])
          end

          def delete(ctx, params:, **)
            ctx[:auto_answer] = ::JeniaBot::AutoAnswerRepository.new.delete(params[:auto_answer_id])
          end
        end
      end
    end
  end
end
