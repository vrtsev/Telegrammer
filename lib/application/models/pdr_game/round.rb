# frozen_string_literal: true

module PdrGame
  class Round < ApplicationRecord
    self.table_name = 'pdr_game_rounds'

    belongs_to :chat
    belongs_to :initiator, class_name: 'User'
    belongs_to :loser, class_name: 'User'
    belongs_to :winner, class_name: 'User'

    validates :chat_id, :initiator_id, :loser_id, :winner_id, presence: true
    validate :winner_loser_difference

    private

    def winner_loser_difference
      return if winner_id != loser_id

      errors.add(:winner_id, 'should not be equal to loser_id')
    end
  end
end
