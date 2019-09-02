module PdrBot
  module Op
    module Bot
      class State < Telegram::AppManager::BaseOperation

        DEFAULT_BOT_STATE = false # To collect chat data first and check if errors present

        step :get_value
        fail :set_value, Output(:success) => Track(:success)
        pass :parse_value
        pass :log

        def get_value(ctx, **)
          ctx[:value] = REDIS.get("#{PdrBot.bot.username}:state")
        end

        def set_value(ctx, **)
          REDIS.set("#{PdrBot.bot.username}:state", DEFAULT_BOT_STATE)
          ctx[:value] = REDIS.get("#{PdrBot.bot.username}:state")
        end

        def parse_value(ctx, **)
          ctx[:enabled] = JSON.parse(ctx[:value])
        end

        def log(ctx, **)
          if ctx[:enabled]
            PdrBot.logger.info "* Bot '#{PdrBot.app_name}' enabled".bold.green
          else
            PdrBot.logger.info "* Bot '#{PdrBot.app_name}' disabled.. Skip processing".bold.red
          end
        end

      end
    end
  end
end
