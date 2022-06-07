# frozen_string_literal: true

module JeniaQuestions
  class GetList < Telegram::AppManager::Service
    class Contract < Dry::Validation::Contract
      params do
        required(:chat_id).filled(:integer)
      end
    end

    attr_reader :questions

    def call
      get_questions
    end

    private

    def get_questions
      @questions = JeniaQuestion
        .where(chat_id: params[:chat_id])
        .order(created_at: :desc)
        .pluck(:text)
    end
  end
end
