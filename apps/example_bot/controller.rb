module ExampleBot
  class Controller < Telegram::AppManager::BaseController
    include ControllerHelpers

    before_action :sync_chat
    before_action :sync_user
    before_action :authenticate_chat
    before_action :sync_message
    before_action :bot_enabled?

    def message(message)
      return unless message['text'].present?
      result = ExampleBot::Op::AutoAnswer::Random.call(
        chat: @current_chat, message: @message
        )
      return if operation_error_present?(result)

      if result[:answer].present?
        respond_with(:message, text: result[:answer])
      else
        message = ExampleBot::Views::ReceivedMessage.new(message: message)
        respond_with(:message, text: message.text)
      end
    end

    def start!
      message = ExampleBot::Views::StartMessage.new
      respond_with(:message, text: message.text)
    end

    private

    def sync_chat
      result = ExampleBot::Op::Chat::Sync.call(params: Hashie.symbolize_keys(chat))
      operation_error_present?(result)
      @current_chat = result[:chat]
    end

    def sync_user
      result = ExampleBot::Op::User::Sync.call(chat: @current_chat, params: Hashie.symbolize_keys(from))
      operation_error_present?(result)
      @current_user = result[:user]
    end

    def authenticate_chat
      throw :abort unless ExampleBot::Op::Chat::Authenticate.call(chat: @current_chat).success?
    end

    def sync_message
      result = ExampleBot::Op::Message::Sync.call(chat: @current_chat, user: @current_user, params: {
        message_id: payload['message_id'],
        text: payload['text'],
        date: payload['date']
      })
      operation_error_present?(result)
      @message = result[:message]
    end

    def bot_enabled?
      result = ::ExampleBot::Op::Bot::State.call
      operation_error_present?(result)
      @bot_enabled = result[:enabled]
      throw :abort unless @bot_enabled
    end

  end
end
