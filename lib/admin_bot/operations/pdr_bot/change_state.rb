module AdminBot
  module Op
    module PdrBot
      class ChangeState < Telegram::AppManager::BaseOperation

        DEFAULT_BOT_STATE = false

        step :get_value
        fail :set_value, Output(:success) => Id(:log)
        pass :parse_value
        pass :change_value
        pass :log

        def get_value(ctx, **)
          ctx[:current_state] = REDIS.get("#{::PdrBot.bot.username}:state")
        end

        def set_value(ctx, **)
          REDIS.set("#{::PdrBot.bot.username}:state", DEFAULT_BOT_STATE)
          default_state = REDIS.get("#{::PdrBot.bot.username}:state")
          ctx[:current_state] = JSON.parse(default_state)

          true
        end

        def parse_value(ctx, **)
          ctx[:current_state] = JSON.parse(ctx[:current_state])
        end

        def change_value(ctx, **)
          new_value = !ctx[:current_state]
          REDIS.set("#{::PdrBot.bot.username}:state", new_value)
          ctx[:current_state] = new_value
        end

        def log(ctx, **)
          if ctx[:current_state]
            ::PdrBot.logger.info "* Bot '#{::PdrBot.app_name}' enabled".bold.green
          else
            ::PdrBot.logger.info "* Bot '#{::PdrBot.app_name}' disabled".bold.red
          end
        end

      end
    end
  end
end
