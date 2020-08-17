# frozen_string_literal: true

module AdminBot
  class Controller < Telegram::AppManager::Controller
    include ControllerHelpers
    include PdrBotActions
    include JeniaBotActions
    include ExampleBotActions
    include AdminBotActions

    exception_handler AdminBot::ExceptionHandler

    before_action :sync_user
    before_action :authenticate_user
    before_action :sync_message
    around_action :with_locale

    # Global 'router' for callback queries
    # Should be defined only once in controller
    def callback_query(query)
      query = Telegram::AppManager::CallbackQuery.parse(query)

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
      handle_callback_failure(result[:error], __method__) unless result.success?
      @current_user = result[:user]
    end

    def authenticate_user
      params = { user_id: @current_user.id }
      result = AdminBot::Op::User::Authenticate.call(params: params)
      handle_callback_failure(result[:error], __method__) unless result.success?
      return if result[:approved]

      ::AdminBot.logger.info "* User #{@current_user.full_name} failed authentication".bold.red

      ::AdminBot::Responders::AdminBot::AccessDenied.new(
        current_chat_id: payload.dig('chat', 'id')
      ).call

      ::AdminBot::Responders::AdminBot::UnauthorizedUserReport.new(
        app_ownwer_chat_id: ENV['TELEGRAM_APP_OWNER_ID'],
        current_user_id: @current_user.id,
        payload_text: payload['text']
      ).call

      throw :abort
    end

    def sync_message
      return unless payload['text'].present?

      params = {
        message_id: payload['message_id'],
        text: payload['text'],
        date: payload['date']
      }
      result = AdminBot::Op::Message::Sync.call(params: params)
      handle_callback_failure(result[:error], __method__) unless result.success?

      @message = result[:message]
    end

    def with_locale(&block)
      # locale switching is not implemented
      I18n.with_locale(AdminBot.default_locale, &block)
    end
  end
end
