# frozen_string_literal: true

module ChatUsers
  class Sync < BaseService
    class Contract < Dry::Validation::Contract
      params do
        required(:chat_id).filled(:integer)
        required(:user_id).filled(:integer)
        optional(:deleted).filled(:bool)
      end
    end

    attr_reader :chat_user

    def call
      sync_chat_user
    end

    private

    def sync_chat_user
      chat_user = ChatUser.find_or_initialize_by(
        chat_id: params[:chat_id],
        user_id: params[:user_id]
      )
      chat_user.update(chat_user_params)
      @chat_user ||= chat_user

      logger.info "> Synced chat user ##{@chat_user.id} #{'(bot)' if @chat_user.user.is_bot?}"
    end

    def chat_user_params
      {
        chat_id: params[:chat_id],
        user_id: params[:user_id],
        deleted_at: (Time.now if params[:deleted])
      }
    end
  end
end
