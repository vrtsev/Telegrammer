# frozen_string_literal: true

module PdrBot
  module Templates
    class CommandException < ApplicationTemplate
      def text
        t('pdr_bot.command_exception')
      end
    end
  end
end
