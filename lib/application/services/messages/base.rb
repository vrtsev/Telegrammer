# frozen_string_literal: true

module Messages
  class Base < BaseService
    private

    def with_delay(&block)
      sleep(params[:delay]) if params[:delay].present?
      block.call
      sleep(params[:delay_after]) if params[:delay_after].present?
    end

    def bot
      @bot ||= Bot.find(params[:bot_id])
    end

    def chat
      @chat ||= Chat.find(params[:chat_id])
    end

    def bot_user
      @bot_user ||= bot.user
    end

    def chat_user
      @chat_user ||= chat.chat_users.find_or_create_by(user_id: bot_user.id)
    end
  end
end
