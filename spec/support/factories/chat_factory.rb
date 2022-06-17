# frozen_string_literal: false

FactoryBot.define do
  factory :chat do
    external_id { Faker::Number.number(digits: 8) }
    approved { true }
    chat_type { Chat.chat_types.values.sample }
    title { Faker::Lorem.sentence }
    username { Faker::Internet.username }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    description { Faker::Lorem.sentence }
    invite_link { Faker::Internet.url }
    all_members_are_administrators { true }
    photo_url { Faker::Internet.url }
  end
end
