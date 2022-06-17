# frozen_string_literal: true

module PdrBot
  module Templates
    class ServiceError < ::BotBase::Templates::BaseTemplate
      class Contract < Dry::Validation::Contract
        params do
          required(:error_code).filled(:string)
        end
      end

      def text
        case params[:error_code]
        when 'PDR_GAME_LATEST_ROUND_NOT_EXPIRED' then latest_round_not_expired_error
        when 'PDR_GAME_NOT_ENOUGH_USERS' then not_enough_users_error
        when 'PDR_GAME_STATS_NOT_FOUND' then stats_not_found_error
        when 'PDR_GAME_NO_ROUNDS' then no_rounds_error
        end
      end

      private

      def latest_round_not_expired_error
        t('pdr_bot.game.errors.latest_round_not_expired')
      end

      def not_enough_users_error
        t('pdr_bot.game.errors.not_enough_users', min_count: PdrGame::Run::MINIMUM_USER_COUNT)
      end

      def stats_not_found_error
        t('pdr_bot.game.errors.stats_not_found')
      end

      def no_rounds_error
        t('pdr_bot.game.errors.no_rounds')
      end
    end
  end
end
