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

    attr_reader :response

    def call
      find_auto_response
    end

    private

    def find_auto_response
      return if params[:message_text].blank?

      @response = AutoResponse
        .where(chat_id: params[:chat_id], bot_id: params[:bot_id])
        .where("? ILIKE '%' || trigger || '%'", params[:message_text])
        .sample&.response
    end
  end
end
