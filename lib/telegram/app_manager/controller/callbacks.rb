# frozen_string_literal: true

module Telegram
  module AppManager
    class Controller < Telegram::Bot::UpdatesController
      module Callbacks
        def log_action(&block)
          return yield unless current_application.config.controller_logging

          logger.log_action(
            app_name: current_application.config.app_name,
            action_name: action_name,
            block: block
          )
        end

        def bot_enabled?
          return if bot_setting.enabled?

          logger.log_callback("Bot is disabled".bold.red)
          throw :abort unless action_name == 'enable!'
        end

        def sync_chat
          chat_params = Builders::Chat.build(chat: chat, bot_setting: bot_setting)
          report_new_chat(chat_params)
          @current_chat = Chat.sync(chat_params, external_id: chat_params[:external_id])

          logger.log_callback("Synced chat: #{@current_chat.name}")
        end

        def sync_user
          user_params = Builders::User.build(user: from)
          @current_user = User.sync(user_params, external_id: user_params[:external_id])

          logger.log_callback("Synced user: #{@current_user.name}")
        end

        def sync_chat_user
          chat_user_params = Builders::ChatUser.build(chat: current_chat, user: current_user)
          @current_chat_user = ChatUser.sync(chat_user_params, chat_id: current_chat.id, user_id: current_user.id)

          logger.log_callback("Synced chat user: #{@current_chat_user.id}")
        end

        def on_user_left_chat
          return unless payload.try(:left_chat_member).present?

          chat_user = ChatUser.joins(:chat, :user).find_by(
            chats: { external_id: current_chat.external_id },
            users: { external_id: payload.left_chat_member.id }
          )
          return if chat_user.blank?

          chat_user.update!(deleted_at: Time.now)
          logger.log_callback("[On user left chat]: Marked chat user #{chat_user.id} as deleted")
        end

        def sync_message
          return if payload.try(:message_id).blank?

          message_params = Builders::Message.build(
            payload: payload,
            chat_user_id: current_chat_user.id,
            bot: current_application.config.telegram_bot
          )
          @current_message = ::Message.sync(message_params, external_id: message_params[:external_id])

          logger.log_callback("Synced message: '#{@current_message.text}'")
        end

        def authenticate_chat!
          return if current_chat.approved?

          logger.log_callback('Chat is not approved for bot')
          throw :abort
        end

        def authorize_admin!
          return if current_user.external_id == Integer(ENV['TELEGRAM_APP_OWNER_ID'])

          logger.warn("> User is not authorized".bold.red)
          throw :abort
        end

        # Another callbacks available:
        # def on_message_pin
        #   payload['pinned_message']

        #   {"message_id"=>111,
        #     "from"=>{"id"=>123456789, "is_bot"=>false, "first_name"=>"Firstname", "username"=>"username", "language_code"=>"en"},
        #     "chat"=>{"id"=>123456789, "title"=>"Title", "type"=>"group", "all_members_are_administrators"=>true},
        #     "date"=>1648395550,
        #     "text"=>"Abc"}
        # end

        private

        def bot_setting
          @bot_setting = BotSetting.find_or_create_by(bot: current_application.config.telegram_bot.username)
        end

        def report_new_chat(chat_params)
          return if Chat.exists?(external_id: chat_params[:external_id])

          response(Responder::NewChatRegistered, chat: chat_params)
        end
      end
    end
  end
end
