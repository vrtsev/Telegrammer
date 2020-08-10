module AdminBot
  module Views
    module PdrBot
      class ChangeStateMessage < Telegram::AppManager::BaseView

        def text
          ::AdminBot.localizer.pick('state.change',
            app_name: ::PdrBot.app_name,
            state: params[:state]
          )
        end

      end
    end
  end
end
