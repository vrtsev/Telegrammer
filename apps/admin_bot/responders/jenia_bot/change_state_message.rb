module AdminBot
  module Views
    module JeniaBot
      class ChangeStateMessage < Telegram::AppManager::BaseView

        def text
          ::AdminBot.localizer.pick('state.change',
            app_name: ::JeniaBot.app_name,
            state: params[:state]
          )
        end

      end
    end
  end
end
