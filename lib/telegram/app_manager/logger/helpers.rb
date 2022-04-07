# frozen_string_literal: true

module Telegram
  module AppManager
    class Logger < ::Logger
      module Helpers
        def log_action(app_name:, action_name:, block:)
          start_time = Time.now

          info action_header_text(app_name, action_name)
          block.call
          info action_footer_text(start_time)
        end

        def log_callback(text)
          info "> #{text}"
        end

        private

        def action_header_text(app_name, action_name)
          "\n[#{app_name}] Processing action :#{action_name.to_s.bold.cyan}"
        end

        def action_footer_text(start_time)
          "Processing completed in #{Time.now - start_time} sec\n"
        end
      end
    end
  end
end
