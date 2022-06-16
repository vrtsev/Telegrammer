# frozen_string_literal: true

module ExampleBot
  class Controller < Telegram::AppManager::Controller
    include Helpers::Logging
    include Helpers::Translation
    include BotBase::Controller::BotState
    include BotBase::Controller::Sync
    include BotBase::Controller::MessageHelpers
    include BotBase::Controller::Events
    include BotBase::Controller::Authorization

    before_action :check_bot_state, except: :enable!
    before_action :sync_request, :sync_bot, :perform_events
    before_action :authorize_admin, only: [:enable!, :disable!]

    def message(payload)
      return unless current_message.text.present?

      params = { chat_id: current_chat.id, message_text: current_message.text, bot_id: bot.id }
      result = AutoResponses::Random.call(params)

      reply_message(
        text: (result.response || t('example_bot.auto_response', message: current_message.text)),
        message_id: current_message.id
      )
    end

    def start!
      send_message(text: t('example_bot.start_message'))
    end

    private

    def handle_exception(exception)
      send_message(BotBase::Templates::ExceptionReport.build(exception: exception, payload: payload))
    end
  end
end
