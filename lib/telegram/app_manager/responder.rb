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

      private

      def respond_with(type, options)
        chat_id = options[:chat_id] || current_chat.external_id

        sleep(options[:delay]) if options[:delay]
        bot.public_send("send_#{type}", options.merge(chat_id: chat_id))
      end

      def reply_with(type, options)
        message_id = options[:reply_to_message_id] || current_message.external_id
        respond_with(type, options.merge(reply_to_message_id: message_id))
      end

      # Currently not used:
      # def answer_inline_query(results, params = {}); end
      # def answer_callback_query(text, params = {}); end
      # def edit_message(type, params = {}); end
      # def answer_pre_checkout_query(ok, params = {}); end
      # def answer_shipping_query(ok, params = {}); end

      def method_missing(method_name, *args, &block)
        return super unless context.instance_variables.include?("@#{method_name}".to_sym)

        context.instance_variable_get("@#{method_name}".to_sym)
      end
    end
  end
end
