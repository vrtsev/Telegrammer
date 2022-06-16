# frozen_string_literal: true

require_relative 'concerns/synchronizable'

class ChatUser < ApplicationRecord
  include Synchronizable

  belongs_to :chat
  belongs_to :user

  has_many :messages, dependent: :destroy
  has_one :pdr_game_stat, class_name: 'PdrGame::Stat'

  validates :chat_id, :user_id, presence: true
  validates :user_id, uniqueness: { scope: :chat_id }

  def pdr_game_stat
    super || create_pdr_game_stat
  end
end
