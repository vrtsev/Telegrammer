# frozen_string_literal: true

module PdrBot
  class Controller < Telegram::AppManager::Controller
    include Helpers::Logging
    include BotBase::Controller::MessageHelpers
    include BotBase::Controller::BotState
    include BotBase::Controller::Sync
    include BotBase::Controller::Events
    include BotBase::Controller::Authorization

    before_action :check_bot_state, :sync_request, :perform_events, :authorize_chat
    before_action :authorize_admin, only: [:enable!, :disable!, :reset_stats!]

    def message(payload)
      return if current_message.text.blank?

      params = { chat_id: current_chat.id, message_text: current_message.text, bot_id: bot.id }
      result = AutoResponses::Random.call(params)
      return if result.response.blank?

      reply_message Templates::AutoResponse.build(response: result.response)
    end

    def start!
      send_message Templates::Start.build(chat_id: current_chat.id)
    end

    def pdr!
      params = { chat_id: current_chat.id, initiator_id: current_user.id }
      result = PdrGame::Run.call(params)
      return respond_with_error(result.exception) unless result.success?

      send_message Templates::Game::Start::Title.build(chat_id: current_chat.id)
      send_message Templates::Game::Start::SearchingUsers.build(chat_id: current_chat.id)
      results!
    end

    def results!
      params = { chat_id: current_chat.id }
      result = PdrGame::Rounds::LatestResults.call(params)
      return respond_with_error(result.exception) unless result.success?

      send_message Templates::Game::Results.build(
        chat_id: current_chat.id,
        winner_name: result.winner.name,
        loser_name: result.loser.name
      )
    end

    def stats!
      params = { chat_id: current_chat.id }
      result = PdrGame::Stats::ByChat.call(params)
      return respond_with_error(result.exception) unless result.success?

      send_message Templates::Game::Stats.build(
        chat_id: current_chat.id,
        winner_leader_stat: result.winner_leader_stat,
        loser_leader_stat: result.loser_leader_stat,
        chat_stats: result.chat_stats
      )
    end

    def reset_stats!
      params = { chat_id: current_chat.id }
      result = PdrGame::Stats::Reset.call(params)
      return respond_with_error(result.exception) unless result.success?
    end

    private

    def respond_with_error(exception)
      send_message Templates::ServiceError.build(chat_id: current_chat.id, error_code: exception.error_code)
    end

    def handle_exception(exception)
      send_message Templates::ExceptionReport.build(exception: exception, payload: payload.to_h)
      send_message Templates::CommandException.build(chat_id: current_chat.id) if action_type == :command
    end
  end
end
