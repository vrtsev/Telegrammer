# frozen_string_literal: true

require_relative 'concerns/synchronizable'

class Message < ApplicationRecord
  include Synchronizable

  belongs_to :bot
  belongs_to :chat_user
  belongs_to :reply_to, class_name: 'Message'

  has_many :replies, class_name: 'Message', foreign_key: :reply_to_id

  delegate :chat, to: :chat_user
  delegate :user, to: :chat_user

  validates :chat_user_id, :payload_type, :external_id, :bot_id, presence: true
  validates :external_id, uniqueness: { scope: :bot_id }

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
    pinned_message: 'pinned_message',
    unknown: 'unknown'
  }

  scope :not_deleted, -> { where(deleted_at: nil) }

  def mark_as_deleted!
    update!(deleted_at: Time.now)
  end
end
