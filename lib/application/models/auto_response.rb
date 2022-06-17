# frozen_string_literal: true

class AutoResponse < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :chat
  belongs_to :bot

  validates :author_id, :chat_id, :bot_id, :trigger, :response, presence: true
end
