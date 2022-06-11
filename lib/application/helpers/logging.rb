# frozen_string_literal: true

module Helpers
  module Logging
    def logger
      Logging.logger
    end

    def self.logger
      @logger ||= Telegram::AppManager.logger
    end
  end
end
