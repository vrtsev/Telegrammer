module PdrBot
  module Views
    class Game < Telegram::AppManager::BaseView

      def game_start_message
        ::PdrBot.localizer.pick('game.start_title')
      end

      def searching_users
        ::PdrBot.localizer.pick('game.searching_users')
      end

    end
  end
end
