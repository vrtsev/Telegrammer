# frozen_string_literal: true

module PdrBot
  module Op
    module AutoAnswer
      class Random < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:chat_id).filled(:integer)
            required(:message_text).filled(:string)
          end
        end

        step :validate
        pass :find_auto_answer
        pass :get_answer

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_auto_answer(ctx, params:, **)
          ctx[:auto_answer] = PdrBot::AutoAnswerRepository.new.find_approved_random_answer(
            params[:chat_id],
            params[:message_text]
          )
        end

        def get_answer(ctx, params:, **)
          ctx[:answer] = ctx[:auto_answer].answer if ctx[:auto_answer].present?
        end
      end
    end
  end
end
