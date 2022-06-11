# # frozen_string_literal: true

module PdrBot
  module Templates
    class Start < ApplicationTemplate
      def text
        t('pdr_bot.start_message')
      end
    end
  end
end
