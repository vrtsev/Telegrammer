# frozen_string_literal: false

FactoryBot.define do
  factory :bot_setting do
    bot { :pdr_bot }
    enabled { true }
    autoapprove_chat { true }
  end
end
