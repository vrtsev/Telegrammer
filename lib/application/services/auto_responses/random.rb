# frozen_string_literal: true

module AutoResponses
  class Random < BaseService
    class Contract < Dry::Validation::Contract
      params do
        required(:chat_id).filled(:integer)
        required(:message_text).filled(:string)
        required(:bot_id).filled(:integer)
      end
    end

    FORBIDDEN_SYMBOLS = '+*?()[]{}/\\'.freeze

    attr_reader :response

    def call
      find_auto_response
    end

    private

    def find_auto_response
      return unless sanitized_message_text.present?

      @response = AutoResponse
        .where(chat_id: params[:chat_id], bot_id: params[:bot_id])
        .where('trigger ~ ?', sanitized_message_text)
        .sample&.response
    end

    def sanitized_message_text
      params[:message_text].delete(FORBIDDEN_SYMBOLS)
    end
  end
end
