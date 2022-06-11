# frozen_string_literal: true

module JeniaBot
  module Templates
    class ServiceError < ApplicationTemplate
      class Contract < Dry::Validation::Contract
        params do
          required(:error_code).filled(:string)
        end
      end

      def text
        # add text for all error codes

        # case params[:error_code]
        # when 'SERVICE_ERROR_1' then service_error_first
        # when 'SERVICE_ERROR_2' then service_error_second
        # end
      end
    end
  end
end
