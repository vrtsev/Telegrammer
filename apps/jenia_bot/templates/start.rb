# frozen_string_literal: true

module JeniaBot
  module Templates
    class Start < ApplicationTemplate
      def text
        t('jenia_bot.start_message')
      end
    end
  end
end
