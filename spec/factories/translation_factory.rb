# frozen_string_literal: false

FactoryBot.define do
  factory :translation do
    association :chat

    key { 'some.random.key' }
    values { ['First', 'Second', 'Third'] }
  end
end
