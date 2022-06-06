# frozen_string_literal: true

require_relative 'concerns/synchronizable'

class Message < ApplicationRecord
  include Synchronizable

  belongs_to :chat_user
  belongs_to :reply_to, class_name: 'Message'
  has_many :replies, class_name: 'Message', foreign_key: :reply_to_id

  validates :chat_user_id, :payload_type, :external_id, presence: true
  validates :external_id, uniqueness: { scope: :chat_user_id }

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
