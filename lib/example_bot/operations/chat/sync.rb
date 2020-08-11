# frozen_string_literal: true

module ExampleBot
  module Op
    module Chat
      class Sync < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            # Chat params
            required(:id).filled(:integer)
            optional(:type).filled(included_in?: ExampleBot::Chat::Types.values)
            optional(:title).filled(:string)
            optional(:username).filled(:string)
            optional(:first_name).filled(:string)
            optional(:last_name).filled(:string)
            optional(:description).filled(:string)
            optional(:invite_link).filled(:string)
          end
        end

        DEFAULT_CHAD_APPROVED_STATE = true

        pass :prepare_params
        step :validate
        step :find_or_create_chat

        def prepare_params(ctx, params:, **)
          params[:type] = ExampleBot::Chat::Types.value(params[:type])
        end

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_or_create_chat(ctx, params:, **)
          ctx[:chat] = ExampleBot::ChatRepository.new.find(params[:id])

          unless ctx[:chat].present?
            ctx[:chat] = create_new_chat(chat_params(params))
            report_to_app_owner(ctx[:chat])
          end

          ctx[:chat]
        end

        private

        def chat_params(params)
          {
            id: params[:id],
            approved: DEFAULT_CHAD_APPROVED_STATE,
            type: params[:type],
            title: params[:title],
            username: params[:username],
            first_name: params[:first_name],
            last_name: params[:last_name],
            description: params[:description],
            invite_link: params[:invite_link]
          }
        end

        def create_new_chat(params)
          ExampleBot::ChatRepository.new.create(params)
        end

        def report_to_app_owner(chat)
          Telegram::AppManager::Message
            .new(Telegram.bots[:admin_bot], I18n.t('.example_bot.new_chat_registered', chat_info: chat.to_hash).sample)
            .send_to_app_owner
        end
      end
    end
  end
end
