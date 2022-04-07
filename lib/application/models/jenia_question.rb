# frozen_string_literal: true

class JeniaQuestion < ActiveRecord::Base
  belongs_to :chat

  validates :chat_id, presence: true
  validates :text,
            presence: true,
            length: { maximum: 255 },
            uniqueness: { scope: :chat_id }
end
