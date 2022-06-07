# frozen_string_literal: true

module PdrBot
  module Responders
    class CommandException < ApplicationResponder
      def call
        respond_with(:message, text: error_text)
      end

      private

      def error_text
        t('pdr_bot.command_exception')
      end
    end
  end
end
