# frozen_string_literal: true

module ExampleBot
  class Controller < Telegram::AppManager::BaseController
    include ControllerHelpers

    before_action :sync_chat
    before_action :sync_user
    before_action :sync_chat_user
    before_action :authenticate_chat
    before_action :sync_message
    before_action :bot_enabled?
    around_action :with_locale

    def message(message)
      return unless message['text'].present?

      params = { chat_id: @current_chat.id, message_text: @message.text }
      result = ExampleBot::Op::AutoAnswer::Random.call(params: params)

      return if operation_error_present?(result)

      ExampleBot::Responders::AutoAnswer.new(
        current_chat_id: @current_chat.id,
        current_message_id: @message.id,
        current_message_text: @message.text,
        auto_answer: result[:answer]
      ).call
    end

    def start!
      params = { user_id: ENV['TELEGRAM_APP_OWNER_ID'] }
      owner_user = ::ExampleBot::Op::User::Find.call(params: params)[:user]

      ExampleBot::Responders::StartMessage.new(
        current_chat_id: @current_chat.id,
        bot_author: owner_user.username
      ).call
    end

    private

    def sync_chat
      params = Hashie.symbolize_keys(chat)
      result = ::ExampleBot::Op::Chat::Sync.call(params: params)
      operation_error_present?(result)
      @current_chat = result[:chat]
    end

    def sync_user
      params = { chat_id: @current_chat.id }.merge(Hashie.symbolize_keys(from))
      result = ::ExampleBot::Op::User::Sync.call(params: params)
      operation_error_present?(result)
      @current_user = result[:user]
    end

    def sync_chat_user
      params = { chat_id: @current_chat.id, user_id: @current_user.id }
      result = ::ExampleBot::Op::ChatUser::Sync.call(params: params)

      operation_error_present?(result)
      @current_chat_user = result[:chat_user]
    end

    def authenticate_chat
      params = { chat_id: @current_chat.id }
      result = ::ExampleBot::Op::Chat::Authenticate.call(params: params)

      unless result[:approved]
        ::ExampleBot.logger.info "* Chat #{@current_chat.id} failed authentication".bold.red
        throw :abort
      end
    end

    def sync_message
      params = {
        chat_id: @current_chat.id,
        user_id: @current_user.id,
        message_id: payload['message_id'],
        text: payload['text'],
        date: payload['date']
      }
      result = ExampleBot::Op::Message::Sync.call(params: params)

      operation_error_present?(result)
      @message = result[:message]
    end

    def bot_enabled?
      result = ::ExampleBot::Op::Bot::State.call

      operation_error_present?(result)
      @bot_enabled = result[:enabled]
      unless @bot_enabled
        ExampleBot.logger.info "* Bot '#{ExampleBot.app_name}' disabled.. Skip processing".bold.red
        throw :abort
      end
    end

    def with_locale(&block)
      # locale switching is not implemented
      I18n.with_locale(ExampleBot.default_locale, &block)
    end
  end
end
