# frozen_string_literal: true

module Telegram
  module AppManager
    class Logger
      class ActionLogMessage
        attr_reader :logger, :params, :start_time

        def initialize(logger, params = {})
          @logger = logger
          @params = params

          @start_time = Time.now
        end

        def call(&_block)
          title_message
          yield
          footer_message
        end

        private

        def title_message
          logger.info <<~MESSAGE.squish
            \nProcessing '#{params[:payload].to_s.bold.cyan}'
            from user #{params[:user_id].to_s.bold.magenta}
            for chat id #{params[:chat_id]}
          MESSAGE
        end

        def footer_message
          logger.info "Processing completed in #{Time.now - start_time} sec\n"
        end
      end
    end
  end
end
