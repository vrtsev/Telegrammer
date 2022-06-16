# frozen_string_literal: true

require_relative 'concerns/synchronizable'

class User < ApplicationRecord
  include Synchronizable

  belongs_to :bot

  has_many :chat_users, dependent: :destroy
  has_many :chats, through: :chat_users
  has_many :pdr_game_stats, through: :chat_users, class_name: 'PdrGame::Stat'

  validates :external_id, presence: true, uniqueness: true

  scope :real, -> { where(is_bot: false) }
  scope :bots, -> { where(is_bot: true) }

  def name
    "#{first_name} #{last_name}".strip.presence || "@#{username}"
  end
end
