# frozen_string_literal: true

module JeniaBot
  module Templates
    class AutoResponse < ApplicationTemplate
      def text
        params[:response]
      end

      def delay
        rand(2..4)
      end
    end
  end
end
