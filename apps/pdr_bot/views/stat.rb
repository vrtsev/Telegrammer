module PdrBot
  module Views
    class Stat < Telegram::AppManager::BaseView

      def text
        content << title
        content << winner_stat
        content << loser_stat
        content << separator

        params[:chat_stats].inject(content) do |content, stat|
          content << user_stat(
            user_full_name(stat),
            stat.winner_count,
            stat.loser_count
          )
          content
        end
      end

      def title
        ::PdrBot.localizer.pick('stats.leaders.title')
      end

      def winner_stat
        ::PdrBot.localizer.pick(
          'stats.leaders.winner_leader',
          user: user_full_name(params[:winner_stat]),
          counter: params[:winner_stat].winner_count
        )
      end

      def loser_stat
        ::PdrBot.localizer.pick(
          'stats.leaders.loser_leader',
          user: user_full_name(params[:loser_stat]),
          counter: params[:loser_stat].loser_count
        )
      end

      def separator
        "\n=======================\n\n"
      end

      def user_stat(user, winner_count, loser_count)
        ::PdrBot.localizer.pick('stats.for_user',
          user: user,
          winner_count: winner_count,
          loser_count: loser_count
        )
      end

      private

      def user_full_name(stat)
        if stat[:first_name].present? || stat[:last_name].present?
          "#{stat[:first_name]} #{stat[:last_name]}"
        else
          stat[:username]
        end
      end

    end
  end
end
