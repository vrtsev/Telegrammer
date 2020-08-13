# frozen_string_literal: true

module Telegram
  module AppManager
    class Logger
      class MultiIO
        def initialize(*targets)
          @targets = targets.compact
        end

        def write(*args)
          @targets.each do |target|
            if target.is_a?(File)
              # Remove colorization
              args.map! { |a| a.gsub(/\e\[(\d+)(;\d+)*m/, '') if a }

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
    end
  end
end
