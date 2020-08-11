# frozen_string_literal: true
require 'logger'

module Telegram
  module AppManager
    class Logger < ::Logger

      LOG_DIR = 'log'

      class MultiIO
        def initialize(*targets)
          @targets = targets.compact
        end

        def write(*args)
          @targets.each do |target|
            if target.is_a?(File)
              # Remove colorization
              args.map! { |a| a.gsub(/\e\[(\d+)(;\d+)*m/, '') }

              target.write(*args)
              target.rewind
            else
              target.write(*args)
            end
          end
        end

        def close
          @targets.each(&:close)
        end
      end

      class DefaultFormatter < ::Logger::Formatter
        def call(severity, time, progname, msg)
          "#{msg2str(msg)}\n"
        end
      end

      def initialize(log_file: nil, **args)
        $stdout.sync = true

        if log_file
          Dir.mkdir(LOG_DIR) unless Dir.exist?(LOG_DIR)
          file = File.open("#{LOG_DIR}/#{log_file}", "a")
        end

        super(MultiIO.new(STDOUT, file), args)
        @default_formatter = DefaultFormatter.new
      end
    end

    class BotLogger < Logger
      def initialize(app_name, **args)
        super(log_file: "#{app_name}.log")
      end
    end
  end
end
