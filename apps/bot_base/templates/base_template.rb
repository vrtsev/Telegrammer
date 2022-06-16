# frozen_string_literal: true

module BotBase
  module Templates
    class BaseTemplate
      include Helpers::Validation
      include Helpers::Translation

      def self.build(**params)
        instance = new(params)
        instance.validate!(params)
        instance.to_h
      end

      attr_reader :params

      def initialize(params)
        @params = params
      end

      def to_h
        payload = { text: text }
        payload.merge!(chat_id: chat_id) if chat_id.present?
        payload.merge!(reply_markup: reply_markup) if reply_markup.present?
        payload.merge!(delay: delay) if delay.present?

        payload
      end

      def text
        raise "Implement '#{__method__}' in your class"
      end

      def chat_id
        nil
      end

      def reply_markup
        nil
      end

      def delay
        nil
      end
    end
  end
end
