# frozen_string_literal: true

module ExampleBot
  module Responders
    class ApplicationResponder < Telegram::AppManager::Responder
      private

      def handle_response(response)
        # sync_message(response)
      end
    end
  end
end
