# frozen_string_literal: true

module PdrBot
  module Op
    module Message
      class Sync < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:id).filled(:integer)
            required(:chat_id).filled(:integer)
            required(:user_id).filled(:integer)
            optional(:text).maybe(:string)
            required(:created_at).filled(:time)
            required(:updated_at).filled(:time)
          end
        end

        pass :prepare_params
        step Macro::Validate(:params, with: Contract)
        step :find_or_create_message

        def prepare_params(ctx, params:, **)
          params[:id] = params[:message_id]
          params[:created_at] = Time.at(params[:date]) if params[:date]
          params[:updated_at] = params[:created_at]
        end

        def find_or_create_message(ctx, params:, **)

          ctx[:message] = ::PdrBot::MessageRepository.new.find_or_create(params[:id], params)
        end
      end
    end
  end
end
