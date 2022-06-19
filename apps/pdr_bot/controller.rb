# frozen_string_literal: true

module PdrBot
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
    before_action :authorize_admin, only: [:enable!, :disable!, :reset_stats!]

    def message(payload)
      return if current_message.text.blank?

      params = { chat_id: current_chat.id, message_text: current_message.text, bot_id: bot.id }
      result = AutoResponses::Random.call(params)
      return if result.response.blank?

      reply_message(text: result.response, delay: rand(2..4))
    end

    def start!
      send_message(text: t('pdr_bot.start_message'))
    end

    def pdr!
      params = { chat_id: current_chat.id, initiator_id: current_user.id }
      result = PdrGame::Run.call(params)
      return respond_with_error(result.exception) unless result.success?

      send_message(text: t('pdr_bot.game.start.title'), delay_after: rand(2..5))
      send_message(text: t('pdr_bot.game.start.searching_users'), delay_after: rand(1..3))
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
      send_message(Templates::ServiceError.build(chat_id: current_chat.id, error_code: exception.error_code))
    end

    def handle_exception(exception)
      send_message(BotBase::Templates::ExceptionReport.build(exception: exception, payload: payload.to_h))
      send_message(text: t('pdr_bot.command_exception')) if action_type == :command
    end
  end
end
