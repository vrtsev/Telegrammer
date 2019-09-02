module AdminBot
  class Controller < Telegram::AppManager::BaseController
    include ControllerHelpers
    include PdrBotActions
    include JeniaBotActions
    include ExampleBotActions
    include AdminBotActions

    self.session_store = :redis_cache_store, { url: REDIS.id, namespace: AdminBot.bot.username }

    before_action :sync_user
    before_action :authenticate_user
    before_action :sync_message

    def callback_query(query)
      query = Telegram::BotManager::CallbackQuery.parse(query)

      case query.params[:bot]
      when 'admin_bot'     then admin_bot(query)
      when 'pdr_bot'       then pdr_bot(query)
      when 'jenia_bot'     then jenia_bot(query)
      when 'example_bot'   then example_bot(query)
      end
    end

    private

    def sync_user
      result = AdminBot::Op::User::Sync.call(params: Hashie.symbolize_keys(from))
      operation_error_present?(result)
      @current_admin = result[:user]
    end

    def authenticate_user
      result = AdminBot::Op::User::Authenticate.call(user: @current_admin)

      unless result.success?
        respond_with(:message, text: AdminBot.localizer.pick('access_denied'))
        throw :abort
      end
    end

    def sync_message
      return unless payload['text'].present?

      result = AdminBot::Op::Message::Sync.call(params: {
        message_id: payload['message_id'],
        text: payload['text'],
        date: payload['date']
      })
      operation_error_present?(result)
      @message = result[:message]
    end

  end
end
