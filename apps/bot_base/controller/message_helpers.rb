# frozen_string_literal: true

module BotBase
  module Controller
    module MessageHelpers
      private

      def send_message(params)
        Messages::Create.call(base_params.merge(params))
      end

      def reply_message(params)
        Messages::Reply.call(base_params.merge(params))
      end

      def edit_message(params)
        Messages::Edit.call(base_params.merge(params))
      end

      def delete_message(params)
        Messages::Delete.call(base_params.merge(params))
      end

      private

      def base_params
        { bot: bot.id, chat_id: current_chat&.id }
      end
    end
  end
end
