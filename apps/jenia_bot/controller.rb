module JeniaBot
  class Controller < Telegram::AppManager::BaseController
    include ControllerHelpers

    before_action :sync_chat
    before_action :sync_user
    before_action :authenticate_chat
    before_action :sync_message
    before_action :bot_enabled?

    def message(message)
      return unless message['text'].present?
      return jenia! if JeniaBot.localizer.samples('triggers').include?(message['text'].strip.chomp)

      result = JeniaBot::Op::AutoAnswer::Random.call(chat: @current_chat, message: @message)
      return if operation_error_present?(result)

      if result[:answer].present?
        # sleep(rand(2..4)) # Currently disabled
        reply_with(:message, text: result[:answer])
      end
    end

    def start!
      message = JeniaBot::Views::StartMessage.new
      respond_with(:message, text: message.text)
    end

    def jenia!(*question)
      result = JeniaBot::Op::Question::GetLast.call
      return if operation_error_present?(result)

      message = JeniaBot::Views::Questions.new(questions: result[:questions])
      respond_with :message, text: message.text, reply_markup: message.markup
    end

    private

    def sync_chat
      result = JeniaBot::Op::Chat::Sync.call(params: Hashie.symbolize_keys(chat))
      operation_error_present?(result)
      @current_chat = result[:chat]
    end

    def sync_user
      result = JeniaBot::Op::User::Sync.call(chat: @current_chat, params: Hashie.symbolize_keys(from))
      operation_error_present?(result)
      @current_user = result[:user]
    end

    def authenticate_chat
      throw :abort unless JeniaBot::Op::Chat::Authenticate.call(chat: @current_chat).success?
    end

    def sync_message
      result = JeniaBot::Op::Message::Sync.call(chat: @current_chat, user: @current_user, params: {
        message_id: payload['message_id'],
        text: payload['text'],
        date: payload['date']
      })
      operation_error_present?(result)
      @message = result[:message]
    end

    def bot_enabled?
      result = ::JeniaBot::Op::Bot::State.call
      operation_error_present?(result)
      @bot_enabled = result[:enabled]
      throw :abort unless @bot_enabled
    end

  end
end
