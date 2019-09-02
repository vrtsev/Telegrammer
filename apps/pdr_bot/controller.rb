module PdrBot
  class Controller < Telegram::AppManager::BaseController
    include ControllerHelpers

    self.session_store = :redis_cache_store, { url: REDIS.id, namespace: PdrBot.bot.username }

    before_action :sync_chat
    before_action :sync_user
    before_action :authenticate_chat
    before_action :sync_message
    before_action :bot_enabled?

    def message(message)
      return unless message['text'].present?
      result = PdrBot::Op::AutoAnswer::Random.call(
        chat: @current_chat, message: @message
      )
      return if operation_error_present?(result)

      if result[:answer].present?
        sleep(rand(2..4))
        reply_with(:message, text: result[:answer])
      end
    end

    def start!
      message = PdrBot::Views::StartMessage.new
      respond_with(:message, text: message.text)
    end

    def pdr!
      result = ::PdrBot::Op::Game::Run.call(user: @current_user, chat: @current_chat)
      return if operation_error_present?(result)

      message = PdrBot::Views::Game.new(winner: result[:winner], loser: result[:loser])
      respond_with(:message, text: message.game_start_message); sleep(rand(0..3))
      respond_with(:message, text: message.searching_users)

      results!
    end

    def results!
      result = ::PdrBot::Op::GameRound::LatestResults.call(user: @current_user, chat: @current_chat)
      return if operation_error_present?(result)

      message = PdrBot::Views::Results.new(winner: result[:winner], loser: result[:loser])
      respond_with(:message, text: message.text)
    end

    def stats!
      result = ::PdrBot::Op::Stat::ByChat.call(chat: @current_chat)
      return if operation_error_present?(result)

      message = PdrBot::Views::Stat.new(
        winner_stat: result[:winner_stat],
        loser_stat: result[:loser_stat],
        chat_stats: result[:chat_stats]
      )
      respond_with(:message, text: message.text)
    end

    private

    def sync_chat
      result = ::PdrBot::Op::Chat::Sync.call(params: Hashie.symbolize_keys(chat))
      operation_error_present?(result)
      @current_chat = result[:chat]
    end

    def sync_user
      result = ::PdrBot::Op::User::Sync.call(chat: @current_chat, params: Hashie.symbolize_keys(from))
      operation_error_present?(result)
      @current_user = result[:user]
    end

    def authenticate_chat
      throw :abort unless ::PdrBot::Op::Chat::Authenticate.call(chat: @current_chat).success?
    end

    def sync_message
      result = PdrBot::Op::Message::Sync.call(chat: @current_chat, params: {
        message_id: payload['message_id'],
        text: payload['text'],
        date: payload['date']
      })
      operation_error_present?(result)
      @message = result[:message]
    end

    def bot_enabled?
      result = ::PdrBot::Op::Bot::State.call
      operation_error_present?(result)
      throw :abort unless result[:enabled]
    end

  end
end
