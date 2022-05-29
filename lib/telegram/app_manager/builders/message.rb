# frozen_string_literal: true

module Telegram
  module AppManager
    module Builders
      class Message < Builder
        CONTENT_BASE_URL = 'https://api.telegram.org/file'.freeze

        def to_h
          {
            payload_type: payload_type,
            chat_user_id: params[:chat_user_id],
            external_id: params[:payload].message_id,
            text: params[:payload].text,
            content_url: content_url,
            content_data: content_data,
            created_at: Time.at(params[:payload].date)
          }
        end

        private

        def payload_type
          ::Message.payload_types.keys.each do |type|
            return ::Message.payload_types[type] if params[:payload].try(type)
          end

          ::Message.payload_types[:unknown]
        end

        def content_url
          case payload_type
          when ::Message.payload_types[:photo]      then url_for(params[:payload].photo.last['file_id'])
          when ::Message.payload_types[:video]      then url_for(params[:payload].video['file_id'])
          when ::Message.payload_types[:document]   then url_for(params[:payload].document['file_id'])
          when ::Message.payload_types[:sticker]    then url_for(params[:payload].sticker['file_id'])
          when ::Message.payload_types[:animation]  then url_for(params[:payload].animation['file_id'])
          when ::Message.payload_types[:voice]      then url_for(params[:payload].voice['file_id'])
          when ::Message.payload_types[:video_note] then url_for(params[:payload].video_note['file_id'])
          end
        end

        def content_data
          case payload_type
          when ::Message.payload_types[:poll]     then params[:payload].poll.to_h
          when ::Message.payload_types[:location] then params[:payload].location.to_h
          when ::Message.payload_types[:contact]  then params[:payload].contact.to_h
          end
        end

        def url_for(file_id)
          request = params[:bot].request(:getFile, file_id: file_id)
          file_path = request.dig('result', 'file_path')

          "#{CONTENT_BASE_URL}/bot#{params[:bot].token}/#{file_path}"
        rescue Telegram::Bot::Error => exception
          logger.error(exception.message)
          nil
        end
      end
    end
  end
end
