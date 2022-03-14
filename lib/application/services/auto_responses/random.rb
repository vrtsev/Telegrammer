# frozen_string_literal: true

module AutoResponses
  class Random < Telegram::AppManager::Service
    class Contract < Telegram::AppManager::Contract
      params do
        required(:chat_id).filled(:integer)
        required(:message_text).filled(:string)
        required(:bot).filled(:symbol)
      end
    end

    attr_reader :response

    def call
      find_auto_response
    end

    private

    def find_auto_response
      @response = AutoResponse
        .where(chat_id: params[:chat_id], bot: params[:bot])
        .where('trigger ~ ?', params[:message_text])
        .sample&.response
    end
  end
end
