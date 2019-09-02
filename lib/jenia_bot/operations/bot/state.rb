module JeniaBot
  module Op
    module Bot
      class State < Telegram::AppManager::BaseOperation

        DEFAULT_BOT_STATE = false # To collect chat data first and check if errors present

        step :get_value
        fail :set_value, Output(:success) => Track(:success)
        pass :parse_value
        pass :log

        def get_value(ctx, **)
          ctx[:value] = REDIS.get("#{JeniaBot.bot.username}:state")
        end

        def set_value(ctx, **)
          REDIS.set("#{JeniaBot.bot.username}:state", DEFAULT_BOT_STATE)
          ctx[:value] = REDIS.get("#{JeniaBot.bot.username}:state")
        end

        def parse_value(ctx, **)
          ctx[:enabled] = JSON.parse(ctx[:value])
        end

        def log(ctx, **)
          if ctx[:enabled]
            JeniaBot.logger.info "* Bot '#{JeniaBot.app_name}' enabled".bold.green
          else
            JeniaBot.logger.info "* Bot '#{JeniaBot.app_name}' disabled.. Skip processing".bold.red
          end
        end

      end
    end
  end
end
