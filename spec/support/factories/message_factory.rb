# frozen_string_literal: false

FactoryBot.define do
  factory :message do
    association :chat_user
    association :bot

    payload_type { 'text' }
    external_id { Faker::Number.number(digits: 8) }
    text { Faker::Lorem.sentence }
    content_url { nil }
    content_data { nil }

    deleted_at { nil }
  end
end
