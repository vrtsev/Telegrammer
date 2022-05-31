# frozen_string_literal: true

module PdrGame
  class Stat < ApplicationRecord
    self.table_name = 'pdr_game_stats'

    belongs_to :chat_user

    delegate :user, to: :chat_user
    delegate :chat, to: :chat_user

    validates :chat_user_id, presence: true, uniqueness: true
  end
end
