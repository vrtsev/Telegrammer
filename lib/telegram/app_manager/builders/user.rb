# frozen_string_literal: true

module Telegram
  module AppManager
    module Builders
      class User < Builder
        def to_h
          {
            external_id: params[:user].id,
            username: params[:user].username,
            first_name: params[:user].first_name,
            last_name: params[:user].last_name,
            is_bot: params[:user].is_bot
          }
        end
      end
    end
  end
end
