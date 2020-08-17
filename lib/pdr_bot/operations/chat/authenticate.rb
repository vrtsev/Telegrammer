# frozen_string_literal: true

module PdrBot
  module Op
    module Chat
      class Authenticate < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:chat_id).filled(:integer)
          end
        end

        step :validate
        step :find_chat
        step :authenticate_chat

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_chat(ctx, params:, **)
          ctx[:chat] = ::PdrBot::ChatRepository.new.find(params[:chat_id])
        end

        def authenticate_chat(ctx, params:, **)
          ctx[:approved] = ctx[:chat].approved
        end
      end
    end
  end
end
