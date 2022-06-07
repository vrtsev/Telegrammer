# frozen_string_literal: true

module JeniaBot
  module Responders
    class ServiceError < Telegram::AppManager::Responder
      class Contract < Dry::Validation::Contract
        params do
          required(:error_code).filled(:string)
        end
      end

      def call
        # uncomment if any service will contain raising of service error
        # respond_with(:message, text: error_text)
      end

      private

      def error_text
        # fill with error codes and corresponding translations
        # case params[:error_code]
        # end
      end
    end
  end
end
