module ExampleBot
  module Op
    module User
      class Sync < Telegram::AppManager::BaseOperation

        class Contract < Dry::Validation::Contract
          params do
            required(:id).filled(:integer)

            optional(:first_name).filled(:string)
            optional(:last_name).filled(:string)
            optional(:username).filled(:string)
          end
        end

        step Macro::Validate(:params, with: Contract)
        step :find_or_create_user
        step :assign_user_to_chat
        step :log

        def find_or_create_user(ctx, params:, **)
          ctx[:user] = ExampleBot::UserRepository.new.find_or_create(params[:id], params)
        end

        def assign_user_to_chat(ctx, params:, **)
          chat_user_params = { chat_id: ctx[:chat].id, user_id: params[:id] }
          chat_user = ExampleBot::ChatUserRepository.new.find_by_chat_and_user(chat_user_params)

          ctx[:chat_user] = chat_user.present? ? chat_user : ExampleBot::ChatUserRepository.new.create(chat_user_params)
        end

        def log(ctx, params:, **)
          ExampleBot.logger.debug "* Synced user ##{ctx[:user].id} (#{ctx[:user].full_name})"
        end

      end
    end
  end
end
