# frozen_string_literal: true

module BotBase
  module Controller
    module MessageHelpers
      def send_message(params)
        Messages::Create.call(base_params.merge(params))
      end

      def reply_message(params)
        Messages::Reply.call(base_params.merge(params).merge(message_id: current_message.id))
      end

      def edit_message(params)
        Messages::Edit.call(base_params.merge(params).merge(message_id: current_message.id))
      end

      def delete_message(params)
        Messages::Delete.call(base_params.merge(params).merge(message_id: current_message.id))
      end

      private

      def base_params
        { bot_id: bot.id, chat_id: current_chat&.id }
      end
    end
  end
end
