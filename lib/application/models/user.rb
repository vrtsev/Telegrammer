# frozen_string_literal: true

require_relative 'concerns/synchronizable'

class User < ApplicationRecord
  include Synchronizable

  has_many :chat_users
  has_many :pdr_game_stats, class_name: 'PdrGame::Stat'

  validates :external_id, presence: true, uniqueness: true

  def name
    username && "@#{username}" || "#{first_name} #{last_name}".strip
  end
end
