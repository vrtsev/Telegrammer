# frozen_string_literal: true

module Messages
  class Reply < Create
    class Contract < Dry::Validation::Contract
      params do
        required(:bot_id).filled(:integer)
        required(:chat_id).filled(:integer)
        required(:text).filled(:string)
        optional(:reply_markup).hash do
          required(:keyboard).filled(:array)
          optional(:resize_keyboard).filled(:bool)
          optional(:one_time_keyboard).filled(:bool)
        end
        optional(:delay).maybe(:integer)
        optional(:delay_after).maybe(:integer)
        required(:message_id).maybe(:integer)
      end
    end

    private

    def send_telegram_message
      with_delay do
        @response = Telegram::AppManager::Client.new(bot.client).reply_message(
          text: params[:text],
          chat_id: chat.external_id,
          reply_markup: params[:reply_markup],
          reply_to_message_id: reply_message.external_id
        )
      end
    end

    def message_params
      super.merge(reply_to_id: reply_message.id)
    end

    def reply_message
      @reply_message ||= chat.messages.find(params[:message_id]) if params[:message_id].present?
    end
  end
end
