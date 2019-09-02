module AdminBot
  module ControllerHelpers

    def operation_error_present?(result)
      return false if result.success?

      if result[:error].present?
        report_to_chat(result[:error]) 
        true
      else
        raise "Operation failed: #{result.to_hash}"
      end
    end

    def rescue_with_handler(exception)
      message = <<~MSG
        #{exception.class}: #{exception.message}
        #{exception.backtrace.first}
      MSG

      puts "[#{AdminBot.app_name}] Application raised exception".bold.red
      puts exception.full_message

      report_app_owner(message)
    end

    def report_app_owner(message)
      Telegram::BotManager::Message
        .new(Telegram.bots[:admin_bot], message)
        .send_to_app_owner
    end

    def logger
      AdminBot.logger
    end
  end
end