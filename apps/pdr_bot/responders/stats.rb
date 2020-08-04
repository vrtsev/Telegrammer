# frozen_string_literal: true

module PdrBot
  module Responders
    class Stats < Telegram::AppManager::BaseResponder
      def call
        send_message(stats_message, bot: Telegram.bots[:pdr_bot], chat_id: params[:current_chat_id])
      end

      def stats_message
        <<~MESSAGE
          #{title}

          #{winner_stat}
          #{loser_stat}

          =======================

          #{chat_stats}
        MESSAGE
      end

      private

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

      def chat_stats
        params[:chat_stats].inject(String.new) do |content, stat|
          content << ::PdrBot.localizer.pick(
            'stats.for_user',
            user: user_full_name(stat),
            winner_count: stat.winner_count,
            loser_count: stat.loser_count
          )
          content << "\n"
          content
        end
      end

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
