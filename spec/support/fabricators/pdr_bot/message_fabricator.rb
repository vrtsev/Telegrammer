# frozen_string_literal: false

Fabricator(:pdr_bot_message, from: 'PdrBot::Message') do
  id                    { Fabricate.sequence(:pdr_bot_message, 1) }
  chat_id               { |attrs| Fabricate(:pdr_bot_chat).id }
  user_id               { |attrs| Fabricate(:pdr_bot_user).id }
  text                  { Faker::Lorem.sentence }

  created_at            { Time.now }
  updated_at            { Time.now }
end
