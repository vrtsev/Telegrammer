# frozen_string_literal: true

module JeniaBot
  module Responders
    class CommandException < ApplicationResponder
      def call
        respond_with(:message, text: error_text)
      end

      private

      def error_text
        t('jenia_bot.command_exception')
      end
    end
  end
end
