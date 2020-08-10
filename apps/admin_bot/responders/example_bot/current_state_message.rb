module AdminBot
  module Views
    module ExampleBot
      class CurrentStateMessage < Telegram::AppManager::BaseView

        def text
          ::AdminBot.localizer.pick('state.current',
            app_name: ::ExampleBot.app_name,
            state: params[:state]
          )
        end

      end
    end
  end
end
