# frozen_string_literal: true

class Bot < ApplicationRecord
  has_one :user
  has_many :messages

  validates :name, :username, presence: true, uniqueness: true

  def client
    Telegram.bots.fetch(name.to_sym)
  end
end
