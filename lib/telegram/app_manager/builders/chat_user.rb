# frozen_string_literal: true

module Telegram
  module AppManager
    module Builders
      class ChatUser < Builder
        def to_h
          {
            chat_id: params[:chat].id,
            user_id: params[:user].id,
            deleted_at: nil
          }
        end
      end
    end
  end
end
