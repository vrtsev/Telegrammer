# frozen_string_literal: false

module Telegram
  module Bot
    class UpdatesController
      class LogSubscriber < ActiveSupport::LogSubscriber
        def start_processing(event)
          return unless AppManager.config.controller_action_logging

          info do
            payload = event.payload
            controller_action = Rainbow("#{payload[:controller]}##{payload[:action]}").bold.cyan

            "Processing by #{controller_action}\n" \
            "  Update: #{payload[:update].to_json}"
          end
        end

        def process_action(event)
          return unless AppManager.config.controller_action_logging

          info do
            payload = event.payload
            additions = UpdatesController.log_process_action(payload)
            message = "Completed in #{event.duration.round}ms"
            message << " (#{additions.join(' | ')})" if additions.present?
            message << "\n"
          end
        end

        def respond_with(event)
          info { "Responded with #{event.payload[:type]}" }
        end

        def halted_callback(event)
          return unless AppManager.config.controller_action_logging

          info { "Filter chain halted at #{event.payload[:filter].inspect}" }
        end

        delegate :logger, to: AppManager
      end
    end
  end
end
