# frozen_string_literal: true

module BotBase
  module Templates
    class ReportNewChat < BaseTemplate
      class Contract < Dry::Validation::Contract
        params do
          required(:chat).filled
        end
      end

      def text
        <<~MSG
          ℹ️ New chat registered
          External ID: #{params[:chat].external_id}
          Chat type: #{params[:chat].chat_type}
          Name: #{params[:chat].name}
        MSG
      end

      def chat_id
        Chat.for_app_owner.id
      end
    end
  end
end
