# frozen_string_literal: true

module PdrBot
  module Responders
    module Game
      class Stats < Telegram::AppManager::Responder
        class Contract < Dry::Validation::Contract
          params do
            required(:winner_leader_stat).filled
            required(:loser_leader_stat).filled
            required(:chat_stats).filled
          end
        end

        def call
          respond_with(:message, text: stats_text)
        end

        private

        def stats_text
          <<~MESSAGE
            #{title}

            #{winner_leader_stat}
            #{loser_leader_stat}
            =====================

            #{chat_stats_text}
          MESSAGE
        end

        def title
          t('pdr_bot.game.stats.leaders.title')
        end

        def winner_leader_stat
          t('pdr_bot.game.stats.leaders.winner',
                          user_name: params[:winner_leader_stat].user.name,
                          count: params[:winner_leader_stat].winner_count)
        end

        def loser_leader_stat
          t('pdr_bot.game.stats.leaders.loser',
                    user_name: params[:loser_leader_stat].user.name,
                    count: params[:loser_leader_stat].loser_count)
        end

        def chat_stats_text
          params[:chat_stats].map do |stat|
            t('pdr_bot.game.stats.chat_user_stat',
                            user_name: stat.user.name,
                            winner_count: stat.winner_count,
                            loser_count: stat.loser_count)
          end.join("\n")
        end
      end
    end
  end
end
