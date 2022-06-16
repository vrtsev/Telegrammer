# frozen_string_literal: true

class PdrGameReminderWorker < BaseWorker
  def perform
    # Currently not used
    # Messages::Send.call(bot: bot, text: t('pdr_bot.game.reminder'), chat_id: chat_user.chat_id)
  end

  private

  def bot
    Telegram.bots[:pdr_bot]
  end
end
