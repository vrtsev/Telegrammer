# frozen_string_literal: true

module AdminBot
  class ExceptionHandler < ::Telegram::AppManager::ExceptionHandler
    def call
      super
      report_app_owner
    end

    private

    def report_app_owner(responder = ::AdminBot::Responders::ExceptionReport)
      responder.new(
        class: exception.class,
        message: exception.message,
        backtrace: exception.backtrace,
        app_name: ::AdminBot.app_name
      ).call
    end
  end
end
