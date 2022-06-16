# frozen_string_literal: true

module Messages
  class Delete < Base
    class Contract < Dry::Validation::Contract
      params do
        required(:bot_id).filled(:integer)
        required(:chat_id).filled(:integer)
        optional(:delay).maybe(:integer)
        optional(:delay_after).maybe(:integer)
        required(:message_id).filled(:integer)
      end
    end

    def call
      delete_telegram_message
      mark_message_as_deleted
    end

    private

    def delete_telegram_message
      with_delay do
        @response = Telegram::AppManager::Client.new(bot.client).delete_message(
          chat_id: chat.external_id,
          message_id: delete_message.external_id
        )
      end
    end

    def mark_message_as_deleted
      delete_message.mark_as_deleted!
    end

    def delete_message
      @delete_message = chat.messages.find(params[:message_id])
    end
  end
end
