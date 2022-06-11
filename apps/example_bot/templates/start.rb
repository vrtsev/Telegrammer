# frozen_string_literal: true

module ExampleBot
  module Templates
    class Start < ApplicationTemplate
      def call
        t('example_bot.start_message')
      end
    end
  end
end
