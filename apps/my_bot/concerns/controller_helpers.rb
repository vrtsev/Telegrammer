module MyBot
  module ControllerHelpers

    ## Use this method to handle operation errors

    # def operation_error_present?(result)
    #   return false if result.success?

    #   if result[:error].present?
    #     report_to_chat(result[:error])
    #     true
    #   else
    #     raise "Operation failed: #{result.to_hash}"
    #   end
    # end

    ## Any exception handlers here

    # def rescue_with_handler(exception)
    #   super(exception)
    # end

    ## Specify your bot logger here to have ability
    ## to see log messages in console

    # def logger
      # MyBot.logger
    # end

  end
end