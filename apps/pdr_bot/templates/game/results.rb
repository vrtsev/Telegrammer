# frozen_string_literal: true

module PdrBot
  module Templates
    module Game
      class Results < ::BotBase::Templates::BaseTemplate
        class Contract < Dry::Validation::Contract
          params do
            optional(:current_chat_id).filled(:integer)
            required(:winner_name).filled(:string)
            required(:loser_name).filled(:string)
          end
        end

        def text
          <<~MESSAGE
            #{title}

            #{winner_leader}
            #{loser_leader}
          MESSAGE
        end

        private

        def title
          t('pdr_bot.game.results.title')
        end

        def winner_leader
          t('pdr_bot.game.results.winner', user_name: params[:winner_name])
        end

        def loser_leader
          t('pdr_bot.game.results.loser', user_name: params[:loser_name])
        end
      end
    end
  end
end
