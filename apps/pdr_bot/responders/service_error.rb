# frozen_string_literal: true

module PdrBot
  module Responders
    class ServiceError < Telegram::AppManager::Responder
      class Contract < Dry::Validation::Contract
        params do
          required(:error_code).filled(:string)
        end
      end

      def call
        respond_with(:message, text: error_text)
      end

      private

      def error_text
        case params[:error_code]
        when 'PDR_GAME_LATEST_ROUND_NOT_EXPIRED' then latest_round_not_expired_error
        when 'PDR_GAME_NOT_ENOUGH_USERS' then not_enough_users_error
        when 'PDR_GAME_STATS_NOT_FOUND' then stats_not_found_error
        when 'PDR_GAME_NO_ROUNDS' then no_rounds_error
        end
      end

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
