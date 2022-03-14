# frozen_string_literal: true

module ExampleBot
  class Controller < Telegram::AppManager::Controller
    def message(payload)
      return unless current_message.text.present?

      params = { chat_id: current_chat.id, message_text: current_message.text, bot: :example_bot }
      result = AutoResponses::Random.call(params)

      response Responders::AutoResponse, response: result.response
    end

    def start!
      app_owner_user = User.find_by(external_id: ENV['TELEGRAM_APP_OWNER_ID'])

      response Responders::StartMessage, bot_author: app_owner_user.username
    end

    private

    def handle_exception(exception)
      response Responders::CommandException if action_type == :command
    end
  end
end
