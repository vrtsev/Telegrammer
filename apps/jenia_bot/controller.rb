# frozen_string_literal: true

module JeniaBot
  class Controller < Telegram::AppManager::Controller
    include Helpers::Logging
    include Helpers::Translation
    include BotBase::Controller::BotState
    include BotBase::Controller::Sync
    include BotBase::Controller::MessageHelpers
    include BotBase::Controller::Events
    include BotBase::Controller::Authorization

    before_action :check_bot_state, except: :enable!
    before_action :sync_request, :sync_bot, :perform_events, :authorize_chat
    before_action :authorize_admin, only: [:enable!, :disable!]

    def message(payload)
      return if current_message.text.blank?

      params = { chat_id: current_chat.id, message_text: current_message.text, bot_id: bot.id }
      result = AutoResponses::Random.call(params)
      return if result.response.blank?

      reply_message(text: result.response, delay: rand(2..3))
    end

    def start!
      send_message(text: t('jenia_bot.start_message'))
    end

    def jenia!
      result = JeniaQuestions::GetList.call(chat_id: current_chat.id)

      params = { chat_id: current_chat.id, message_text: current_message.text, bot_id: bot.id }
      auto_response = AutoResponses::Random.call(params)

      reply_message Templates::CallJenia.build(
        chat_id: current_chat.id,
        response: auto_response.response,
        questions: result.questions
      )
    end

    private

    def handle_exception(exception)
      send_message(BotBase::Templates::ExceptionReport.build(exception: exception, payload: payload.to_h))
    end
  end
end
