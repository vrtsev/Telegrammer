module AdminBot
  module Views
    module JeniaBot
      class StartMessage < Telegram::AppManager::BaseView

        def markup
          { inline_keyboard: [
              [
                { text: "Current state",  callback_data: callback_data(bot: 'jenia_bot', action: 'current_state!') },
                { text: "Change state",   callback_data: callback_data(bot: 'jenia_bot', action: 'change_state!') }
              ], [
                { text: 'Say from bot',   callback_data: callback_data(bot: 'jenia_bot', action: 'say!') },
                { text: 'Question',       callback_data: callback_data(bot: 'jenia_bot', action: 'question!') },
                { text: 'Auto answer',    callback_data: callback_data(bot: 'jenia_bot', action: 'auto_answer!') },
                { text: '<- All bots',    callback_data: callback_data(bot: 'admin_bot', action: 'start!') }
              ]
            ]
          }
        end

        def text
          ::AdminBot.localizer.pick('jenia_bot.start_message', app_name: ::JeniaBot.app_name)
        end

      end
    end
  end
end
