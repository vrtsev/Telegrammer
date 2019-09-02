module ExampleBot
  module Views
    class ReceivedMessage < Telegram::AppManager::BaseView

      def text
        ExampleBot.localizer.pick('actions.message', message: params[:message])
      end

    end
  end
end
