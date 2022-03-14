# frozen_string_literal: true

module Telegram
  module AppManager
    class Logger < ::Logger
      class ActiveRecordFormatter < DefaultFormatter
        FORBIDDEN_LOG_STATEMENTS = ['SET ', 'TRANSACTION', 'SELECT '].freeze

        def call(_severity, _time, _progname, msg)
          "#{msg2str(msg)}\n" unless forbidden_statements_present?(msg)
        end

        private

        def forbidden_statements_present?(msg)
          FORBIDDEN_LOG_STATEMENTS.any? { |statement| msg.include?(statement) }
        end
      end
    end
  end
end
