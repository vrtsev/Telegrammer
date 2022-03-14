# frozen_string_literal: false

FactoryBot.define do
  factory :chat_user do
    association :user
    association :chat

    deleted_at { nil }
  end
end
