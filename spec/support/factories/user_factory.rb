# frozen_string_literal: false

FactoryBot.define do
  factory :user do
    external_id { Faker::Number.number(digits: 8) }
    username { Faker::Internet.username }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    is_bot { false }
    bot { nil }
  end

  factory :bot_user, parent: :user do
    is_bot { true }
    bot { :example_bot }
  end
end
