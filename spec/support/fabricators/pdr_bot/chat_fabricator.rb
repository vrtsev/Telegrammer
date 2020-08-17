# frozen_string_literal: false

Fabricator(:pdr_bot_chat, from: 'PdrBot::Chat') do
  id                  { Fabricate.sequence(:pdr_bot_message, 1) }
  approved            true
  type                { ::PdrBot::Chat::Types.private }

  title               { Faker::Lorem.words(number: 4).join(' ') }
  username            { Faker::Internet.username }
  first_name          { Faker::Name.first_name }
  last_name           { Faker::Name.last_name }
  description         { Faker::Lorem.sentence }
  invite_link         { Faker::Internet.url }

  created_at          { Time.now }
  updated_at          { Time.now }
end
