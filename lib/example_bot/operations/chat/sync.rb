module ExampleBot
  module Op
    module Chat
      class Sync < Telegram::AppManager::BaseOperation

        class Contract < Dry::Validation::Contract
          params do
            required(:id).filled(:integer)
            required(:type).filled(:string)

            optional(:title).filled(:string)
            optional(:username).filled(:string)
            optional(:first_name).filled(:string)
            optional(:last_name).filled(:string)
            optional(:description).filled(:string)
            optional(:invite_link).filled(:string)
          end
        end

        step Macro::Validate(:params, with: Contract)
        pass :prepare_params
        step :find_or_create_chat
        step :log

        def prepare_params(ctx, params:, **)
          params[:type] = ExampleBot::Chat::Types.value(params[:type])
        end

        def find_or_create_chat(ctx, params:, **)
          ctx[:chat] = ExampleBot::ChatRepository.new.find(params[:id])

          unless ctx[:chat].present?
            ctx[:chat] = ExampleBot::ChatRepository.new.create(params)
            report_to_app_owner(ctx[:chat])
          end

          ctx[:chat]
        end

        def log(ctx, params:, **)
          ExampleBot.logger.debug "* Synced chat ##{ctx[:chat].id} (#{ctx[:chat].name})"
        end

        private

        def report_to_app_owner(chat)
          Telegram::BotManager::Message
            .new(Telegram.bots[:admin_bot], ExampleBot.localizer.pick('new_chat_registered', chat_info: chat.to_hash))
            .send_to_app_owner
        end

      end
    end
  end
end
