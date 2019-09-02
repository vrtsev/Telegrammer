module PdrBot
  module Views
    class Results < Telegram::AppManager::BaseView

      def text
        content << title
        content << winner_leader
        content << loser_leader
      end

      def title
        ::PdrBot.localizer.pick('latest_results.results.title')
      end

      def winner_leader
        ::PdrBot.localizer.pick('latest_results.results.loser', user: params[:loser].full_name)
      end

      def loser_leader
        ::PdrBot.localizer.pick('latest_results.results.winner',user: params[:winner].full_name)
      end

    end
  end
end
