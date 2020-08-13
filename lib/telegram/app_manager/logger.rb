# frozen_string_literal: true

module Telegram
  module AppManager
    class Logger < ::Logger
      class DefaultFormatter < ::Logger::Formatter
        def call(severity, time, progname, msg)
          "#{msg2str(msg)}\n"
        end
      end

      def initialize(log_file = nil, **args)
        $stdout.sync = true

        if log_file
          dirname = File.dirname(log_file)
          FileUtils.mkdir_p(dirname) unless File.directory?(dirname)

          @file = File.open(log_file, 'a')
        end

        super(MultiIO.new(STDOUT, @file), args)
        @default_formatter = DefaultFormatter.new
      end
    end
  end
end
