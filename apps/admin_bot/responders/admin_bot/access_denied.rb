# frozen_string_literal: true

module AdminBot
  module Responders
    module AdminBot
      class AccessDenied < Telegram::AppManager::BaseResponder
        def call
          message(
            text,
            bot: Telegram.bots[:admin_bot],
            chat_id: params[:current_chat_id]
          ).send
        end

        private

        def text
          I18n.t('.admin_bot.access_denied').sample
        end
      end
    end
  end
end
