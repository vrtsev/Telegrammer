# frozen_string_literal: true

module PdrBot
  module Op
    module Message
      class Sync < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:chat_id).filled(:integer)
            required(:user_id).filled(:integer)
            required(:message_id).filled(:integer)
            optional(:text).maybe(:string)
            required(:created_at).filled(:time)
            required(:updated_at).filled(:time)
          end
        end

        pass :prepare_params
        step :validate
        step :find_or_create_message

        def prepare_params(ctx, params:, **)
          params[:created_at] = Time.at(params[:date]) if params[:date]
          params[:updated_at] = params[:created_at]
        end

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_or_create_message(ctx, params:, **)
          ctx[:message] = ::PdrBot::MessageRepository.new.find_or_create(params[:message_id], message_params(params))
        end

        private

        def message_params(params)
          {
            id: params[:message_id],
            chat_id: params[:chat_id],
            user_id: params[:user_id],
            text: params[:text],
            created_at: params[:created_at],
            updated_at: params[:updated_at]
          }
        end
      end
    end
  end
end
