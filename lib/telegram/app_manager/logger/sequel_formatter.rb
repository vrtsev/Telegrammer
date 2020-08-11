# frozen_string_literal: true

module Telegram
  module AppManager
    class Logger
      class SequelFormatter < Telegram::AppManager::Logger::DefaultFormatter

        FORBIDDEN_LOG_STATEMENTS = ['SET ', 'SELECT ']

        def call(severity, time, progname, msg)
          return if FORBIDDEN_LOG_STATEMENTS.any? { |statement| msg.include?(statement) }

          msg = msg.sub("INSERT INTO", "INSERT INTO".bold.green)
          msg = msg.sub("COMMIT", "COMMIT".bold)

          "   [SQL] " + msg2str(msg) + "\n"
        end

        private

        def format_datetime(time)
          time.strftime(@datetime_format || "%Y-%m-%d %H:%M:%S")
        end

      end
    end
  end
end