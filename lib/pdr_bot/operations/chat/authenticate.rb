# frozen_string_literal: true

module PdrBot
  module Op
    module Chat
      class Authenticate < Telegram::AppManager::BaseOperation
        step :find_chat
        step :authenticate_chat

        def find_chat(ctx, **)
          ctx[:chat] = ::PdrBot::ChatRepository.new.find(ctx[:chat_id])
        end

        def authenticate_chat(ctx, **)
          ctx[:approved] = ctx[:chat].approved
        end
      end
    end
  end
end
