# frozen_string_literal: true

module JeniaBot
  class ExceptionHandler < ::Telegram::AppManager::ExceptionHandler
    def call
      super
      report_app_owner
      report_to_chat
    end

    private

    def report_app_owner(responder = ::JeniaBot::Responders::ExceptionReport)
      responder.new(
        class: exception.class,
        message: exception.message,
        backtrace: exception.backtrace
      ).call
    end

    def report_to_chat(responder=nil)
      # unless bot_enabled
      # avoid respond to each message
      # only to commands

      # ::JeniaBot::Responders::ApplicationCrash
      I18n.t('.jenia_bot.errors').sample
      # ///
    end
  end
end
