# frozen_string_literal: false

module Telegram
  module AppManager
    module Helpers
      module Responding
        def response(responder_class, bot: nil, **params)
          responder_class.call(context: self, bot: (bot || application_bot), params: params)
        end

        private

        def application_bot
          self.class.module_parent::Application.config.telegram_bot
        end
      end
    end
  end
end
