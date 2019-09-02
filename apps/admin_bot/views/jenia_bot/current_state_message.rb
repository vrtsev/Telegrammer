module AdminBot
  module Views
    module JeniaBot
      class CurrentStateMessage < Telegram::AppManager::BaseView

        def text
          ::AdminBot.localizer.pick('state.current',
            app_name: ::JeniaBot.app_name,
            state: params[:state]
          )
        end

      end
    end
  end
end
