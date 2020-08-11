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
      operation_error_present?(result)
      @current_user = result[:user]
    end

    def authenticate_user
      params = { user_id: @current_user.id }
      result = AdminBot::Op::User::Authenticate.call(params: params)
      return if result[:approved]

      ::AdminBot.logger.info "* User #{@current_user.full_name} failed authentication".bold.red

      ::AdminBot::Responders::AdminBot::AccessDenied.new(
        current_chat_id: payload.dig('chat', 'id')
      ).call

      Telegram::AppManager::Message.new(
        Telegram.bots[:admin_bot],
        "Unauthorized user '#{@current_user.id}' send message: '#{payload['text']}'"
      ).send_to_app_owner

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

      operation_error_present?(result)
      @message = result[:message]
    end

    def with_locale(&block)
      # locale switching is not implemented
      I18n.with_locale(AdminBot.default_locale, &block)
    end
  end
end
