module AdminBot
  module Views
    module PdrBot
      class CurrentStateMessage < Telegram::AppManager::BaseView

        def text
          ::AdminBot.localizer.pick('state.current',
            app_name: ::PdrBot.app_name,
            state: params[:state]
          )
        end

      end
    end
  end
end
