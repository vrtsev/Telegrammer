# frozen_string_literal: true

class BotSetting < ActiveRecord::Base
  validates :bot, presence: true
end
