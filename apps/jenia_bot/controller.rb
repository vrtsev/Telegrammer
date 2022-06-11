# frozen_string_literal: true

module JeniaBot
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
      return if current_message.text.blank?
      return if auto_response.response.blank?

      reply_message Templates::AutoResponse.build(response: auto_response.response)
    end

    def start!
      send_message Templates::Start.build(chat_id: current_chat.id)
    end

    def jenia!
      params = { chat_id: current_chat.id }
      result = JeniaQuestions::GetList.call(params)

      reply_message Templates::CallJenia.build(
        chat_id: current_chat.id,
        response: auto_response.response,
        questions: result.questions
      )
    end

    private

    def auto_response
      params = { chat_id: current_chat.id, message_text: current_message.text, bot: :jenia_bot }
      AutoResponses::Random.call(params)
    end

    def respond_with_error(exception)
      send_message Templates::ServiceError.build(chat_id: current_chat.id, error_code: exception.error_code)
    end

    def handle_exception(exception)
      send_message Templates::CommandException.build(chat_id: current_chat.id) if action_type == :command
    end
  end
end
