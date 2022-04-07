# frozen_string_literal: true

module PdrBot
  class Controller < Telegram::AppManager::Controller
    before_action :authorize_admin!, only: [:say!, :clear_stats!]

    def message(payload)
      return unless current_message.text.present?

      params = { chat_id: current_chat.id, message_text: current_message.text, bot: :pdr_bot }
      result = AutoResponses::Random.call(params)

      response Responders::AutoResponse, response: result.response
    end

    def start!
      app_owner_user = User.find_by(external_id: ENV['TELEGRAM_APP_OWNER_ID'])

      response Responders::StartMessage, bot_author: app_owner_user.username
    end

    def pdr!
      params = { chat_id: current_chat.id, initiator_id: current_user.id }
      result = PdrGame::Run.call(params)
      return respond_with_error(result.exception) unless result.success?

      response Responders::Game::Start
      results!
    end

    def results!
      params = { chat_id: current_chat.id }
      result = PdrGame::Rounds::LatestResults.call(params)
      return respond_with_error(result.exception) unless result.success?

      response Responders::Game::Results, winner_name: result.winner.name, loser_name: result.loser.name
    end

    def stats!
      params = { chat_id: current_chat.id }
      result = PdrGame::Stats::ByChat.call(params)
      return respond_with_error(result.exception) unless result.success?

      response(
        Responders::Game::Stats,
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
      response Responders::ServiceError, error_code: exception.error_code
    end

    def handle_exception(exception)
      response Responders::CommandException if action_type == :command
    end
  end
end
