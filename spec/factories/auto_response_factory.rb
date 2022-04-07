# frozen_string_literal: false

FactoryBot.define do
  factory :auto_response do
    association :author, factory: :user
    association :chat

    bot { 'example_bot' }
    trigger { Faker::Lorem.sentence }
    response { Faker::Lorem.sentence }
  end
end
