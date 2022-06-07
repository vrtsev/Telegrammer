# frozen_string_literal: true

module PdrBot
  module Responders
    class AutoResponse < ApplicationResponder
      def call
        return if params[:response].blank?

        reply_with(:message, text: params[:response], delay: rand(2..4))
      end
    end
  end
end
