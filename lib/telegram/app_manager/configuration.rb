# frozen_string_literal: true

module Telegram
  module AppManager
    class Configuration
      include ActiveModel::Validations

      DEFAULT_CONTROLLER_LOGING_ENABLED = true
      DEFAULT_LOG_TO_FILE_ONLY = false

      attr_accessor :app_name,
                    :environment,
                    :telegram_bot,
                    :controller,
                    :controller_action_logging,
                    :log_to_file_only,
                    :logger

      validates :app_name, presence: true, length: { minimum: 1, maximum: 100 }
      validates :telegram_bot, :controller, presence: true

      validate :telegram_bot_object
      validate :controller_object

      def initialize
        @app_name = nil
        @environment = nil
        @telegram_bot = nil
        @controller = nil
        @controller_action_logging = DEFAULT_CONTROLLER_LOGING_ENABLED
        @log_to_file_only = DEFAULT_LOG_TO_FILE_ONLY
        @logger = nil
      end

      private

      def telegram_bot_object
        return if telegram_bot.is_a?(Telegram::Bot::Client)

        errors.add(:telegram_bot, "should be 'Telegram::Bot::Client'")
      end

      def controller_object
        return if controller.ancestors.include?(Telegram::Bot::UpdatesController)

        errors.add(:controller, "should have 'Telegram::Bot::UpdatesController' ancestor")
      end
    end
  end
end
