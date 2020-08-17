# frozen_string_literal: true

module Telegram
  module AppManager
    module Bot
      module ClassMethods
        def self.included(base)
          base.extend ClassMethods
        end

        module ClassMethods
          attr_writer :logger

          def configuration
            @configuration ||= Bot::Configuration.new
          end

          def configure
            yield(configuration)
          end

          def app_name
            @app_name ||= configuration.app_name
          end

          def default_locale
            @default_locale ||= configuration.default_locale
          end

          def logger
            @logger ||= configuration.logger
          end
        end
      end
    end
  end
end
