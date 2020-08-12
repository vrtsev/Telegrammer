# frozen_string_literal: true

module ExampleBot
  class ExceptionHandler < ::Telegram::AppManager::ExceptionHandler
    def call
      super
      report_app_owner
      report_to_chat
    end

    private

    def report_app_owner(responder = ::ExampleBot::Responders::ExceptionReport)
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

      # ::ExampleBot::Responders::ApplicationCrash
      I18n.t('.example_bot.errors').sample
      # ///
    end
  end
end
