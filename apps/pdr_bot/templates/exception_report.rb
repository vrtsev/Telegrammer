# frozen_string_literal: true

module PdrBot
  module Templates
    class ExceptionReport < ApplicationTemplate
      class Contract < Dry::Validation::Contract
        params do
          required(:exception).filled
          required(:payload).hash do
            required(:chat).filled(:hash)
            required(:from).filled(:hash)
          end
        end
      end

      def text
        <<~MSG
          ⚠️ EXCEPTION REPORT

          Chat: #{params[:payload][:chat]}
          User: #{params[:payload][:from]}
          Text: (##{params[:payload][:message_id]}) '#{params[:payload][:text]}'

          #{params[:exception].class}: #{params[:exception].message}
          #{params[:exception].backtrace.first}
        MSG
      end

      def chat_id
        Chat.for_app_owner.id
      end
    end
  end
end
