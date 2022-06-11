# frozen_string_literal: true

module ExampleBot
  module Templates
    class AutoResponse < ApplicationTemplate
      def text
        params[:response] || t('example_bot.auto_response', message: params[:message])
      end
    end
  end
end
