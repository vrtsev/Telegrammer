# frozen_string_literal: true

module JeniaBot
  module Responders
    class AutoResponse < Telegram::AppManager::Responder
      def call
        return if params[:response].blank?

        reply_with(:message, text: params[:response], delay: rand(2..4))
      end
    end
  end
end