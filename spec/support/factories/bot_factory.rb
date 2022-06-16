# frozen_string_literal: false

FactoryBot.define do
  factory :bot do
    name { :example_bot }
    username { 'dev_example_bot' }
    enabled { true }
    autoapprove_chat { true }
  end
end
