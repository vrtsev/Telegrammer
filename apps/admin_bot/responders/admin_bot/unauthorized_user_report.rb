# frozen_string_literal: true

module AdminBot
  module Responders
    module AdminBot
      class UnauthorizedUserReport < Telegram::AppManager::BaseResponder
        def call
          message(
            text,
            bot: Telegram.bots[:admin_bot],
            chat_id: params[:app_ownwer_chat_id]
          ).send
        end

        private

        def text
          "Unauthorized user '#{params[:current_user_id]}' sent message: '#{params[:payload_text]}'"
        end
      end
    end
  end
end
