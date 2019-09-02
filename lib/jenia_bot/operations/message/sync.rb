module JeniaBot
  module Op
    module Message
      class Sync < Telegram::AppManager::BaseOperation

        class Contract < Dry::Validation::Contract
          params do
            required(:id).filled(:integer)
            required(:chat_id).filled(:integer)
            optional(:text).maybe(:string)
            required(:created_at).filled(:time)
            required(:updated_at).filled(:time)
          end
        end

        pass :prepare_params
        step Macro::Validate(:params, with: Contract)
        step :find_or_create_message
        step :log

        def prepare_params(ctx, params:, **)
          params[:id] = params[:message_id]
          params[:chat_id] = ctx[:chat].id
          params[:created_at] = Time.at(params[:date]) if params[:date]
          params[:updated_at] = params[:created_at]
        end

        def find_or_create_message(ctx, params:, **)
          ctx[:message] = ::JeniaBot::MessageRepository.new.find_or_create(params[:id], params)
        end

        def log(ctx, params:, **)
          JeniaBot.logger.debug "* Synced message ##{ctx[:message].id} (#{ctx[:message].text})"
        end

      end
    end
  end
end
