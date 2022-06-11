# frozen_string_literal: true

module BotBase
  module Controller
    module Events

      # Following events available:
      # def my_chat_member(payload); end
      # def edited_message(payload); end
      # def channel_post; end
      # def edited_channel_post; end
      # def inline_query; end
      # def chosen_inline_result; end
      # def callback_query; end
      # def shipping_query; end
      # def pre_checkout_query; end
      # def poll(payload); end # listens only stopped polls sent by the bot
      # def poll_answer(payload); end # listens only stopped polls sent by the bot
      # def chat_member; end # needs admin rights && explicitly specify “chat_member” in the list of allowed_updates to receive these updates

      private

      def perform_events
        on_new_chat_member
        on_left_chat_member
      end

      def on_new_chat_member
        return if payload['new_chat_members'].blank?

        payload['new_chat_members'].each do |new_chat_member|
          new_user = sync_user(new_chat_member.to_h)
          chat_user = sync_chat_user(chat_id: current_chat.id, user_id: new_user.id, deleted: false)

          logger.info("> [New chat member] synced chat user ##{chat_user.id}")
        end
      end

      def on_left_chat_member
        return if payload[:left_chat_member].blank?

        left_user = sync_user(payload['left_chat_member'])
        chat_user = sync_chat_user(chat_id: current_chat.id, user_id: left_user.id, deleted: true)

        logger.info("> [Left chat member]: synced chat user ##{chat_user.id}")
      end
    end
  end
end
