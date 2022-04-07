# frozen_string_literal: true

module Telegram
  module AppManager
    class Logger < ::Logger
      class DefaultFormatter < ::Logger::Formatter
        def call(_severity, _time, _progname, msg)
          "#{msg2str(msg)}\n"
        end
      end
    end
  end
end
