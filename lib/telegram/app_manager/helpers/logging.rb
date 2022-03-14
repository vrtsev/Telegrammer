# frozen_string_literal: false

module Telegram
  module AppManager
    module Helpers
      module Logging
        def logger
          Logging.logger
        end

        def self.logger
          @logger ||= Logger.new('log/application.log')
        end
      end
    end
  end
end
