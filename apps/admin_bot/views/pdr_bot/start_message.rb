module AdminBot
  module Views
    module PdrBot
      class StartMessage < Telegram::AppManager::BaseView

        def markup
          { inline_keyboard: [
            [
              { text: "Current state",  callback_data: callback_data(bot: 'pdr_bot',   action: 'current_state!') },
              { text: "Change state",   callback_data: callback_data(bot: 'pdr_bot',   action: 'change_state!') }
            ], [
              { text: 'Say from bot',   callback_data: callback_data(bot: 'pdr_bot',   action: 'say!') },
              { text: 'Auto answer',    callback_data: callback_data(bot: 'pdr_bot',   action: 'auto_answer!') },
              { text: '<- All bots',    callback_data: callback_data(bot: 'admin_bot', action: 'start!') }
            ]
          ]
          }
        end

        def text
          ::AdminBot.localizer.pick('pdr_bot.start_message', app_name: ::PdrBot.app_name)
        end

      end
    end
  end
end
