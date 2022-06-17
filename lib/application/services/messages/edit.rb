# frozen_string_literal: true

module Messages
  class Edit < Base
    class Contract < Dry::Validation::Contract
      params do
        required(:bot_id).filled(:integer)
        required(:chat_id).filled(:integer)
        required(:text).filled(:string)
        optional(:reply_markup).filled(:hash)
        optional(:delay).maybe(:integer)
        optional(:delay_after).maybe(:integer)
        required(:message_id).filled(:integer)
      end
    end

    def call
      edit_telegram_message
      update_message
    end

    private

    def edit_telegram_message
      with_delay do
        @response = Telegram::AppManager::Client.new(bot.client).edit_message(
          text: params[:text],
          chat_id: chat.external_id,
          message_id: edit_message.external_id
        )
      end
    end

    def update_message
      edit_message.update!(message_params)
    end

    def message_params
      {
        payload_type: 'text',
        text: params[:text],
        updated_at: Time.at(@response[:edit_date])
      }
    end

    def edit_message
      @edit_message ||= chat.messages.find(params[:message_id])
    end
  end
end
