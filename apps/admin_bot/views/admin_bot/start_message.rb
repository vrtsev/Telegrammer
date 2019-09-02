module AdminBot
  module Views
    module AdminBot
      class StartMessage < Telegram::AppManager::BaseView

        def markup
          { inline_keyboard: [[
              { text: 'PdrBot',       callback_data: callback_data(bot: 'pdr_bot',   action: 'start!') },
              { text: 'JeniaBot',     callback_data: callback_data(bot: 'jenia_bot', action: 'start!') },
              { text: 'ExampleBot',   callback_data: callback_data(bot: 'example_bot', action: 'start!') },
            ]]
          }
        end

        def text
          ::AdminBot.localizer.pick('start_message', role: ::AdminBot::User::Roles.key(params[:role]))
        end

      end
    end
  end
end
