# frozen_string_literal: true

class PdrGameReminderWorker < Telegram::AppManager::Worker
  def perform
    # Currently not used
    # response(PdrBot::Responders::Game::Reminder, bot: bot, chat_id: chat_user.chat_id)
  end

  private

  def bot
    Telegram.bots[:pdr_bot]
  end
end
