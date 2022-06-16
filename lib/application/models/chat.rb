# frozen_string_literal: true

require_relative 'concerns/synchronizable'

class Chat < ApplicationRecord
  include Synchronizable

  has_many :chat_users, dependent: :destroy
  has_many :users, -> { order('users.id') }, through: :chat_users
  has_many :messages, -> { order('messages.id') }, through: :chat_users
  has_many :pdr_game_stats, through: :chat_users, class_name: 'PdrGame::Stat'
  has_many :pdr_game_rounds, class_name: 'PdrGame::Round'
  has_many :translations
  has_many :auto_responses
  has_many :jenia_questions

  validates :external_id, :chat_type, :approved, presence: true
  validates :external_id, uniqueness: true

  enum chat_type: {
    private_chat: 'private',
    group_chat: 'group',
    supergroup: 'supergroup',
    channel: 'channel'
  }

  def name
    title || username || "#{first_name} #{last_name}".strip
  end

  def pdr_game_round
    super || build_pdr_game_round
  end
end
