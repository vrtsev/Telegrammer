# frozen_string_literal: true

module AdminBot
  module Op
    module PdrBot
      module State
        class Enable < Telegram::AppManager::BaseOperation
          step :update_state
          pass :get_state

          def update_state(ctx, **)
            REDIS.set(redis_bot_state_key, true)
          end

          def parse_value(ctx, **)
            value = REDIS.get(redis_bot_state_key)
            ctx[:enabled] = JSON.parse(value)
          end

          private

          def redis_bot_state_key
            "#{::Telegram.bots[:pdr_bot].username}:state"
          end
        end
      end
    end
  end
end
