module AdminBot
  module Views
    module ExampleBot
      class ChangeStateMessage < Telegram::AppManager::BaseView

        def text
          ::AdminBot.localizer.pick('state.change',
            app_name: ::ExampleBot.app_name,
            state: params[:state]
          )
        end

      end
    end
  end
end
