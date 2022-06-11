# frozen_string_literal: true

module JeniaBot
  module Templates
    class CommandException < ApplicationTemplate
      def text
        t('jenia_bot.command_exception')
      end
    end
  end
end
