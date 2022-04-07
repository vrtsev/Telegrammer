# frozen_string_literal: true

module JeniaBot
  class Controller < Telegram::AppManager::Controller
    def message(payload)
      return unless current_message.text.present?

      response Responders::AutoResponse, response: auto_response.response
    end

    def start!
      app_owner_user = User.find_by(external_id: ENV['TELEGRAM_APP_OWNER_ID'])

      response Responders::StartMessage, bot_author: app_owner_user.username
    end

    def jenia!
      params = { chat_id: current_chat.id }
      result = JeniaQuestions::GetList.call(params)

      response Responders::CallJenia, response: auto_response.response, questions: result.questions
    end

    private

    def auto_response
      params = { chat_id: current_chat.id, message_text: current_message.text, bot: :jenia_bot }
      AutoResponses::Random.call(params)
    end

    def respond_with_error(exception)
      response Responders::ServiceError, error_code: exception.error_code
    end

    def handle_exception(exception)
      response Responders::CommandException if action_type == :command
    end
  end
end
