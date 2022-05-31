# frozen_string_literal: true

class BotSetting < ApplicationRecord
  validates :bot, presence: true
end
