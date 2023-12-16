# frozen_string_literal: true

module Messages
  class Create < Base
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
      end
    end

    attr_reader :message

    def call
      send_telegram_message
      create_message
    end

    private

    def send_telegram_message
      with_delay do
        @response = Telegram::AppManager::Client.new(bot.client).send_message(
          text: params[:text],
          chat_id: chat.external_id,
          reply_markup: params[:reply_markup]
        )
      end
    end

    def create_message
      @message = chat_user.messages.create!(message_params)
    rescue ActiveRecord::RecordInvalid
      # TODO needs proper refactoring
      logger.error "[EXTERNAL ID ERROR] Failed to create a message with params: #{message_params}"
      true
    end

    def message_params
      {
        chat_user_id: chat_user.id,
        payload_type: 'text',
        external_id: @response[:message_id],
        text: @response[:text],
        bot_id: bot.id,
        created_at: message_timestamp,
        updated_at: message_timestamp
      }
    end

    def message_timestamp
      Time.at(@response[:date])
    end
  end
end
