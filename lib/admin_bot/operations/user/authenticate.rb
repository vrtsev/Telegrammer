module AdminBot
  module Op
    module User
      class Authenticate < Telegram::AppManager::BaseOperation

        step :is_admin?
        fail :log

        def is_admin?(ctx, **)
          return if ctx[:user].role == ::AdminBot::User::Roles.not_approved
          true
        end

        def log(ctx, **)
          AdminBot.logger.info "* User #{ctx[:user].full_name} failed authentication".bold.red
        end

      end
    end
  end
end
