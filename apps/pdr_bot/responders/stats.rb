# frozen_string_literal: true

module PdrBot
  module Responders
    class Stats < Telegram::AppManager::BaseResponder
      def call
        message(stats_message, bot: Telegram.bots[:pdr_bot], chat_id: params[:current_chat_id]).send
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
        I18n.t('.pdr_bot.stats.leaders.title').sample
      end

      def winner_stat
        I18n.t(
          '.pdr_bot.stats.leaders.winner_leader',
          user: user_full_name(params[:winner_stat]),
          counter: params[:winner_stat].winner_count
        ).sample
      end

      def loser_stat
        I18n.t(
          'pdr_bot.stats.leaders.loser_leader',
          user: user_full_name(params[:loser_stat]),
          counter: params[:loser_stat].loser_count
        ).sample
      end

      def chat_stats
        params[:chat_stats].inject(String.new) do |content, stat|
          content << I18n.t(
            'pdr_bot.stats.for_user',
            user: user_full_name(stat),
            winner_count: stat.winner_count,
            loser_count: stat.loser_count
          ).sample
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
