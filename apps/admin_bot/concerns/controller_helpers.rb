# frozen_string_literal: true

module AdminBot
  module ControllerHelpers
    def respond_with_error(op_result)
      raise "Operation failed: #{op_result.to_hash}" unless op_result[:error].present?

      ::AdminBot::Responders::Error.new(
        error_msg: op_result[:error],
        current_chat_id: @current_chat.id
      ).call
    end

    # Used in BaseController for action logging
    def logger
      AdminBot.logger
    end
  end
end
