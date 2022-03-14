# frozen_string_literal: true

module Telegram
  module AppManager
    class Logger < ::Logger
      include Logger::Helpers

      attr_reader :file_path

      def initialize(file_path = nil, **args)
        @file_path = file_path
        super(logdev, args)

        @default_formatter = DefaultFormatter.new
        $stdout.sync = true
      end

      private

      def log_file
        dirname = File.dirname(file_path)
        FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
        FileUtils.touch(file_path) unless File.exists?(file_path)
        File.open(file_path, 'a')
      end

      def logdev
        targets = Array.new
        targets << STDOUT   if ENV['CONSOLE_LOGGING'] == 'true'
        targets << log_file if file_path.present?

        MultiIO.new(targets)
      end
    end
  end
end
