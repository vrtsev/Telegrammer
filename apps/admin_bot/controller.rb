# frozen_string_literal: true

module AdminBot
  class Controller < Telegram::AppManager::BaseController
    include ControllerHelpers
    include PdrBotActions
    include JeniaBotActions
    include ExampleBotActions
    include AdminBotActions

    before_action :sync_user
    before_action :authenticate_user
    before_action :sync_message

    # Global 'router' for callback queries
    # Should be defined only once in controller
    def callback_query(query)
      query = Telegram::BotManager::CallbackQuery.parse(query)

      case query.params[:bot]
      when 'admin_bot'   then admin_bot_callback_query(query)
      when 'pdr_bot'     then pdr_bot_callback_query(query)
      when 'jenia_bot'   then jenia_bot_callback_query(query)
      when 'example_bot' then example_bot_callback_query(query)
      end
    end

    private

    def sync_user
      params = Hashie.symbolize_keys(from)
      result = ::AdminBot::Op::User::Sync.call(params: params)
      operation_error_present?(result)
      @current_user = result[:user]
    end

    def authenticate_user
      params = { user_id: @current_user.id }
      result = AdminBot::Op::User::Authenticate.call(params: params)

      unless result[:approved]
        ::AdminBot.logger.info "* User #{@current_user.full_name} failed authentication".bold.red
        # respond_with(:message, text: AdminBot.localizer.pick('access_denied'))
        # Responder
        # notify admin (and sent message text)
        throw :abort
      end
    end

    def sync_message
      return unless payload['text'].present?

      params = {
        message_id: payload['message_id'],
        text: payload['text'],
        date: payload['date']
      }
      result = AdminBot::Op::Message::Sync.call(params: params)

      operation_error_present?(result)
      @message = result[:message]
    end
  end
end
