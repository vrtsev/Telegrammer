# frozen_string_literal: true

module AdminBot
  module Responders
    module AdminBot
      class StartMessage < Telegram::AppManager::BaseResponder
        def call
          if params[:current_message].present?
            edit_message(
              text,
              bot: Telegram.bots[:admin_bot],
              chat_id: params[:current_chat_id],
              reply_markup: markup
            )
          else
            send_message(
              text,
              bot: Telegram.bots[:admin_bot],
              chat_id: params[:current_chat_id],
              reply_markup: markup
            )
          end
        end

        private

        def markup
          { inline_keyboard: [[
              { text: 'PdrBot',       callback_data: callback_data(bot: 'pdr_bot',   action: 'start!') },
              { text: 'JeniaBot',     callback_data: callback_data(bot: 'jenia_bot', action: 'start!') },
              { text: 'ExampleBot',   callback_data: callback_data(bot: 'example_bot', action: 'start!') }
            ]]
          }
        end

        def text
          ::AdminBot.localizer.pick('start_message', role: params[:role])
        end
      end
    end
  end
end
