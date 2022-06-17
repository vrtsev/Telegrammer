# frozen_string_literal: true

module Messages
  class Sync < Base
    class Contract < Dry::Validation::Contract
      params do
        required(:bot_id).filled(:integer)
        required(:payload).filled(:hash)
        required(:chat_user_id).filled(:integer)
      end
    end

    attr_reader :message

    def call
      sync_message
    end

    private

    def sync_message
      @message = Message.sync_by!(:external_id, message_params)

      logger.info "> Synced message ##{@message.id}"
    end

    def message_params
      {
        chat_user_id: params[:chat_user_id],
        external_id: params.dig(:payload, 'message_id'),
        text: params.dig(:payload, 'text'),
        created_at: Time.at(params.dig(:payload, 'date')),
        bot_id: bot.id,

        reply_to_id: reply_to_id,
        payload_type: payload_type,
        content_url: content_url,
        content_data: content_data
      }
    end

    def reply_to_id
      external_id = params.dig(:payload, 'reply_to_message', 'message_id')
      Message.find_by(external_id: external_id)&.id
    end

    def payload_type
      ::Message.payload_types.keys.each do |type|
        return ::Message.payload_types[type] if params[:payload].key?(type)
      end

      ::Message.payload_types[:unknown]
    end

    def content_url
      file_id = case payload_type
      when ::Message.payload_types[:photo]      then content.last['file_id']
      when ::Message.payload_types[:video]      then content['file_id']
      when ::Message.payload_types[:document]   then content['file_id']
      when ::Message.payload_types[:sticker]    then content['thumb']['file_id']
      when ::Message.payload_types[:animation]  then content['file_id']
      when ::Message.payload_types[:voice]      then content['file_id']
      when ::Message.payload_types[:video_note] then content['file_id']
      else return
      end

      Telegram::AppManager::Client.new(bot.client).file_url(file_id)
    rescue Telegram::Bot::Error => exception
      logger.error "[Client] Error: #{exception.message}"
      nil
    end

    def content_data
      case payload_type
      when ::Message.payload_types[:text] then nil
      when ::Message.payload_types[:photo] then content.last.to_h
      else content.to_h
      end
    end

    def content
      params[:payload][payload_type]
    end
  end
end
