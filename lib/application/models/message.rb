# frozen_string_literal: true

require_relative 'concerns/synchronizable'

class Message < ActiveRecord::Base
  include Synchronizable

  belongs_to :chat_user

  validates :chat_user_id, :payload_type, :external_id, presence: true
  validates :external_id, uniqueness: true

  enum payload_type: {
    text: 'text',
    photo: 'photo',
    video: 'video',
    document: 'document',
    poll: 'poll',
    location: 'location',
    contact: 'contact',
    sticker: 'sticker',
    animation: 'animation',
    voice: 'voice',
    video_note: 'video_note',
    unknown: 'unknown'
  }
end
