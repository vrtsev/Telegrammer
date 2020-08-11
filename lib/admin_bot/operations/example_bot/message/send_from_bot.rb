# frozen_string_literal: true

module AdminBot
  module Op
    module ExampleBot
      module Message
        class SendFromBot < Telegram::AppManager::BaseOperation
          class Contract < Dry::Validation::Contract
            params do
              required(:chat_id).filled(:integer)
              required(:text).filled(:string)
            end
          end

          step :validate
          step :send

          def validate(ctx, params:, **)
            ctx[:validation_result] = Contract.new.call(params)
            ctx[:params] = ctx[:validation_result].to_h

            handle_validation_errors(ctx)
          end

          def send(ctx, params:, **)
            ::Telegram::AppManager::Message.new(::Telegram.bots[:example_bot], params[:text]).send_to_chat(params[:chat_id])
          end
        end
      end
    end
  end
end
