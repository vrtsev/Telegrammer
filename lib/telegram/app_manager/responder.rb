# frozen_string_literal: true

module Telegram
  module AppManager
    class Responder
      include Helpers::Logging
      include Helpers::Validation

      def self.call(context:, bot:, params:)
        new(context: context, bot: bot, params: params)
      end

      attr_reader :context, :bot, :params

      def initialize(context:, bot:, params:)
        @context = context
        @bot = bot
        @params = params

        validate
        call
      end

      def call
        raise "Implement method `call` in #{self.class}"
      end

      def respond_with(type, delay: nil, **options)
        sleep(delay) if delay.present?
        options[:chat_id] ||= current_chat.external_id

        request("send_#{type}", options)
      end

      def reply_with(type, delay: nil, **options)
        options[:reply_to_message_id] ||= current_message.external_id

        respond_with(type, delay: delay, options)
      end

      def edit_message(type, delay: nil, **options)
        sleep(delay) if delay.present?

        request("edit_message_#{type}", options)
      end

      def delete_message(type, delay: nil, **options)
        sleep(delay) if delay.present?

        request("delete_message_#{type}", options)
      end

      # Currently not used:
      # def answer_inline_query(results, params = {}); end
      # def answer_callback_query(text, params = {}); end
      # def answer_pre_checkout_query(ok, params = {}); end
      # def answer_shipping_query(ok, params = {}); end

      private

      def request(action, options)
        response = bot.public_send(action, options)

        handle_response(response)
      end

      def handle_response(response)
        logger.debug('[Telegram] performed message action')
      end

      def t(key, **params)
        Translation.for(key, **params.merge!(chat_id: current_chat.id))
      end

      def method_missing(method_name, *args, &block)
        return super unless context.instance_variables.include?("@#{method_name}".to_sym)

        context.instance_variable_get("@#{method_name}".to_sym)
      end
    end
  end
end
