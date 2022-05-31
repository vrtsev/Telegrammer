# frozen_string_literal: true

class AutoResponse < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :chat

  validates :author_id, :chat_id, :bot, :trigger, :response, presence: true

  enum bot: {
    example_bot: 'example_bot',
    jenia_bot: 'jenia_bot',
    pdr_bot: 'pdr_bot'
  }
end
