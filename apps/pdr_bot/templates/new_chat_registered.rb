# frozen_string_literal: true

module PdrBot
  module Templates
    class NewChatRegistered < ApplicationTemplate
      class Contract < Dry::Validation::Contract
        params do
          required(:chat).hash do
            optional(:title).filled(:string)
            optional(:username).filled(:string)
            optional(:first_name).filled(:string)
            optional(:last_name).filled(:string)
          end
        end
      end

      def text
        <<~MSG
          ℹ️ New chat registered

          External ID: #{params.dig(:chat, :external_id)}
          Chat type: #{params.dig(:chat, :chat_type)}
          Name: #{chat_name}
        MSG
      end

      def chat_id
        Chat.for_app_owner.id
      end

      private

      def chat_name
        [
          params.dig(:chat, :title),
          params.dig(:chat, :username),
          params.dig(:chat, :first_name),
          params.dig(:chat, :last_name)
        ].compact.join(' / ')
      end
    end
  end
end
