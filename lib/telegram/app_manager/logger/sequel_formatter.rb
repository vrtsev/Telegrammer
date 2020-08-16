# frozen_string_literal: true

module Telegram
  module AppManager
    class Logger
      class SequelFormatter < DefaultFormatter
        FORBIDDEN_LOG_STATEMENTS = ['SET ', 'SELECT '].freeze
        MESSAGE_PREFIX = "\t[SQL] "

        def call(severity, time, progname, msg)
          return if forbidden_statements_present?(msg)

          msg = msg.sub('INSERT INTO', 'INSERT INTO'.bold.green)
          msg = msg.sub('UPDATE', 'UPDATE'.bold.yellow)
          msg = msg.sub('DELETE FROM', 'DELETE FROM'.bold.red)
          msg = msg.sub('COMMIT', 'COMMIT'.bold)

          MESSAGE_PREFIX + msg2str(msg) + "\n"
        end

        private

        def forbidden_statements_present?(msg)
          FORBIDDEN_LOG_STATEMENTS.any? { |statement| msg.include?(statement) }
        end

        def format_datetime(time)
          time.strftime(@datetime_format || '%Y-%m-%d %H:%M:%S')
        end
      end
    end
  end
end
