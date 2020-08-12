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

    def report_to_chat
      return unless ::JeniaBot::Op::Bot::State.call[:enabled]
      return unless action_options[:type] == :command

      ::JeniaBot::Responders::ApplicationCrash.new(
        current_chat_id: payload['chat']['id']
      ).call
    end
  end
end
