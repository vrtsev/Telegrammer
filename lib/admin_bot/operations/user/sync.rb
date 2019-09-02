module AdminBot
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
        pass :log

        def find_or_create_user(ctx, params:, **)
          ctx[:user] = AdminBot::UserRepository.new.find_or_create(params[:id], params)
        end

        def log(ctx, params:, **)
          AdminBot.logger.debug "* Synced user ##{ctx[:user].id} (#{ctx[:user].full_name})"
        end

      end
    end
  end
end
