# frozen_string_literal: true

module PdrBot
  class Controller < Telegram::AppManager::BaseController
    include ControllerHelpers

    before_action :sync_chat
    before_action :sync_user
    before_action :sync_chat_user
    before_action :authenticate_chat
    before_action :sync_message
    before_action :bot_enabled?

    def message(message)
      return unless message['text'].present?

      params = { chat_id: @current_chat.id, message_text: @message.text }
      result = PdrBot::Op::AutoAnswer::Random.call(params: params)

      return if operation_error_present?(result)
      return unless result[:answer].present?

      PdrBot::Responders::AutoAnswer.new(
        current_chat_id: @current_chat.id,
        current_message_id: @message.id,
        auto_answer: result[:answer]
      ).call
    end

    def start!
      params = { user_id: ENV['TELEGRAM_APP_OWNER_ID'] }
      owner_user = ::PdrBot::Op::User::Find.call(params: params)[:user]

      PdrBot::Responders::StartMessage.new(
        current_chat_id: @current_chat.id,
        bot_author: owner_user.username
      ).call
    end

    def pdr!
      params = { chat_id: @current_chat.id, user_id: @current_user.id }
      result = ::PdrBot::Op::Game::Run.call(params: params)
      return if operation_error_present?(result)

      PdrBot::Responders::Game.new(current_chat_id: @current_chat.id).call
      results!
    end

    def results!
      params = { chat_id: @current_chat.id }
      result = ::PdrBot::Op::GameRound::LatestResults.call(params: params)
      return if operation_error_present?(result)

      PdrBot::Responders::Results.new(
        current_chat_id: @current_chat.id,
        winner_full_name: result[:winner].full_name,
        loser_full_name: result[:loser].full_name
      ).call
    end

    def stats!
      params = { chat_id: @current_chat.id }
      result = ::PdrBot::Op::Stat::ByChat.call(params: params)
      return if operation_error_present?(result)

      PdrBot::Responders::Stats.new(
        current_chat_id: @current_chat.id,
        winner_stat: result[:winner_stat],
        loser_stat: result[:loser_stat],
        chat_stats: result[:chat_stats]
      ).call
    end

    private

    def sync_chat
      result = ::PdrBot::Op::Chat::Sync.call(params: Hashie.symbolize_keys(chat))
      operation_error_present?(result)
      @current_chat = result[:chat]
    end

    def sync_user
      params = { chat_id: @current_chat.id }.merge(Hashie.symbolize_keys(from))
      result = ::PdrBot::Op::User::Sync.call(params: params)
      operation_error_present?(result)
      @current_user = result[:user]
    end

    def sync_chat_user
      params = { chat_id: @current_chat.id, user_id: @current_user.id }
      result = ::PdrBot::Op::ChatUser::Sync.call(params: params)

      operation_error_present?(result)
      @current_chat_user = result[:chat_user]
    end

    def authenticate_chat
      params = { chat_id: @current_chat.id }
      result = ::PdrBot::Op::Chat::Authenticate.call(params: params)

      unless result[:approved]
        ::PdrBot.logger.info "* Chat #{@current_chat.id} failed authentication".bold.red
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
      result = PdrBot::Op::Message::Sync.call(params: params)

      operation_error_present?(result)
      @message = result[:message]
    end

    def bot_enabled?
      result = ::PdrBot::Op::Bot::State.call

      operation_error_present?(result)
      @bot_enabled = result[:enabled]
      unless @bot_enabled
        PdrBot.logger.info "* Bot '#{PdrBot.app_name}' disabled.. Skip processing".bold.red
        throw :abort
      end
    end
  end
end
