# frozen_string_literal: true

module Telegram
  module AppManager
    module BotClassMethods
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        attr_writer :localizer, :logger

        def configuration
          @configuration ||= BotConfiguration.new
        end

        def configure
          yield(configuration)
        end

        def app_name
          @app_name ||= configuration.app_name
        end

        def locale
          @locale ||= configuration.locale
        end

        def localizer
          @localizer ||= configuration.localizer
        end

        def logger
          @logger ||= configuration.logger
        end

        def bot
          @bot ||= configuration.bot
        end
      end
    end
  end
end