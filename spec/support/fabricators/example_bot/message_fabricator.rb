# frozen_string_literal: false

Fabricator(:example_bot_message, from: 'ExampleBot::Message') do
  id                  { Fabricate.sequence(:example_bot_message, 1) }
  chat_id             { |_attrs| Fabricate(:example_bot_chat).id }
  user_id             { |_attrs| Fabricate(:example_bot_user).id }
  text                { Faker::Lorem.sentence }

  created_at          { Time.now }
  updated_at          { Time.now }
end
