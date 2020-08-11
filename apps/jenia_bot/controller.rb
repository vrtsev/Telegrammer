# frozen_string_literal: true

module JeniaBot
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

      trigger = JeniaBot::Op::Trigger::FindLocalized.call(params: { message_text: message['text'] })[:trigger]
      return jenia! if trigger.present?

      params = { chat_id: @current_chat.id, message_text: @message.text }
      result = JeniaBot::Op::AutoAnswer::Random.call(params: params)
      return if operation_error_present?(result)
      return unless result[:answer].present?

      JeniaBot::Responders::AutoAnswer.new(
        current_chat_id: @current_chat.id,
        current_message_id: @message.id,
        auto_answer: result[:answer]
      ).call
    end

    def start!
      params = { user_id: ENV['TELEGRAM_APP_OWNER_ID'] }
      owner_user = ::JeniaBot::Op::User::Find.call(params: params)[:user]

      JeniaBot::Responders::StartMessage.new(
        current_chat_id: @current_chat.id,
        bot_author: owner_user.username
      ).call
    end

    def jenia!(*question)
      result = JeniaBot::Op::Question::GetLast.call
      return if operation_error_present?(result)

      JeniaBot::Responders::Questions.new(
        current_chat_id: @current_chat.id,
        questions: result[:questions]
      ).call
    end

    private

    def sync_chat
      params = Hashie.symbolize_keys(chat)
      result = ::JeniaBot::Op::Chat::Sync.call(params: params)
      operation_error_present?(result)
      @current_chat = result[:chat]
    end

    def sync_user
      params = { chat_id: @current_chat.id }.merge(Hashie.symbolize_keys(from))
      result = ::JeniaBot::Op::User::Sync.call(params: params)
      operation_error_present?(result)
      @current_user = result[:user]
    end

    def sync_chat_user
      params = { chat_id: @current_chat.id, user_id: @current_user.id }
      result = ::JeniaBot::Op::ChatUser::Sync.call(params: params)

      operation_error_present?(result)
      @current_chat_user = result[:chat_user]
    end

    def authenticate_chat
      params = { chat_id: @current_chat.id }
      result = ::JeniaBot::Op::Chat::Authenticate.call(params: params)

      unless result[:approved]
        ::JeniaBot.logger.info "* Chat #{@current_chat.id} failed authentication".bold.red
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
      result = JeniaBot::Op::Message::Sync.call(params: params)

      operation_error_present?(result)
      @message = result[:message]
    end

    def bot_enabled?
      result = ::JeniaBot::Op::Bot::State.call

      operation_error_present?(result)
      @bot_enabled = result[:enabled]
      unless @bot_enabled
        JeniaBot.logger.info "* Bot '#{JeniaBot.app_name}' disabled.. Skip processing".bold.red
        throw :abort
      end
    end

    def with_locale(&block)
      # locale switching is not implemented
      I18n.with_locale(JeniaBot.default_locale, &block)
    end
  end
end
