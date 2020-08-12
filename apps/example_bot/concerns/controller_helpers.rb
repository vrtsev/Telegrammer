module ExampleBot
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

    # Used in BaseController for action logging
    def logger
      ExampleBot.logger
    end
  end
end
