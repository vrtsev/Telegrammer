module AdminBot
  module Views
    module ExampleBot
      class StartMessage < Telegram::AppManager::BaseView

        def markup
          { inline_keyboard: [
              [
                { text: "Current state",  callback_data: callback_data(bot: 'example_bot', action: 'current_state!') },
                { text: "Change state",   callback_data: callback_data(bot: 'example_bot', action: 'change_state!') }
              ], [
                { text: 'Auto answer',    callback_data: callback_data(bot: 'example_bot', action: 'auto_answer!') },
                { text: '<- All bots',    callback_data: callback_data(bot: 'admin_bot', action: 'start!') }
              ]
            ]
          }
        end

        def text
          ::AdminBot.localizer.pick('example_bot.start_message', app_name: ::ExampleBot.app_name)
        end

      end
    end
  end
end
