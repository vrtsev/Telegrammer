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

          pass :prepare_params
          step Macro::Validate(:params, with: Contract)
          step :create

          def prepare_params(ctx, params:, **)
            params[:author_id] = ENV['TELEGRAM_APP_OWNER_ID']
          end

          def create(ctx, params:, **)
            ctx[:auto_answer] = ::JeniaBot::AutoAnswer.create(params)
          end

        end
      end
    end
  end
end
