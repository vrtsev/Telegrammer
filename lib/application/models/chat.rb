# frozen_string_literal: true

require_relative 'concerns/synchronizable'

class Chat < ActiveRecord::Base
  include Synchronizable

  has_many :chat_users

  validates :external_id, :chat_type, presence: true
  validates :external_id, uniqueness: true

  enum chat_type: {
    private_chat: 'private',
    group_chat: 'group',
    supergroup: 'supergroup',
    channgel: 'channel'
  }

  def name
    title || username || "#{first_name} #{last_name}".strip
  end
end
