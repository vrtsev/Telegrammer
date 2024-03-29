# frozen_string_literal: true

module PdrBot
  module Templates
    module Game
      class Stats < ::BotBase::Templates::BaseTemplate
        class Contract < Dry::Validation::Contract
          params do
            optional(:current_chat_id).filled(:integer)
            required(:winner_leader_stat).filled
            required(:loser_leader_stat).filled
            required(:chat_stats).filled
          end
        end

        def text
          <<~MESSAGE
            #{title}

            #{winner_leader_stat}
            #{loser_leader_stat}
            =====================

            #{chat_stats_text}
          MESSAGE
        end

        private

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
