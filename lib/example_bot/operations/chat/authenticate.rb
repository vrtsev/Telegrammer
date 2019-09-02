module ExampleBot
  module Op
    module Chat
      class Authenticate < Telegram::AppManager::BaseOperation

        step :authenticate_chat

        def authenticate_chat(ctx, **)
          ctx[:approved] = ctx[:chat].approved

          if ctx[:approved]
            ::ExampleBot.logger.info "* Chat id #{ctx[:chat].id} is authenticated".bold.green
          else
            ::ExampleBot.logger.info "* Chat #{ctx[:chat].id} failed authentication".bold.red
          end

          ctx[:approved]
        end

      end
    end
  end
end
