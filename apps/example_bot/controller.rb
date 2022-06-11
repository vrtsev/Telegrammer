# frozen_string_literal: true

module ExampleBot
  class Controller < Telegram::AppManager::Controller
    include Helpers::Logging
    include BotBase::Controller::BotState
    include BotBase::Controller::Sync
    include BotBase::Controller::MessageHelpers
    include BotBase::Controller::Events
    include BotBase::Controller::Authorization

    before_action :check_bot_state, :sync_request, :perform_events, :authorize_chat
    before_action :authorize_admin, only: [:enable!, :disable!]

    def message(payload)
      return unless current_message.text.present?

      params = { chat_id: current_chat.id, message_text: current_message.text, bot: :example_bot }
      result = AutoResponses::Random.call(params)
      return if result.response.blank?

      reply_message Templates::AutoResponse.build(
        chat_id: current_chat.id,
        response: auto_response.response,
        message: current_message.text
      )
    end

    def start!
      send_message Templates::Start.build(chat_id: current_chat.id)
    end

    private

    def handle_exception(exception)
      send_message Templates::ExceptionReport.build(exception: exception, payload: payload.to_h)
    end
  end
end
