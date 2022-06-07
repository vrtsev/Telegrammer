# frozen_string_literal: true

module PdrBot
  module Responders
    module Game
      class Results < ApplicationResponder
        class Contract < Dry::Validation::Contract
          params do
            required(:winner_name).filled(:string)
            required(:loser_name).filled(:string)
          end
        end

        def call
          respond_with(:message, text: results_text)
        end

        private

        def results_text
          <<~MESSAGE
            #{title}

            #{winner_leader}
            #{loser_leader}
          MESSAGE
        end

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
