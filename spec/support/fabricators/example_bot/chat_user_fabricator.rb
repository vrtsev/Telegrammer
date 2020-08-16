# frozen_string_literal: false

Fabricator(:example_bot_chat_user, from: 'ExampleBot::ChatUser') do
  id                  { Fabricate.sequence(:example_bot_message, 1) }
  user_id             { Fabricate(:example_bot_user).id }
  chat_id             { Fabricate(:example_bot_chat).id }

  created_at          { Time.now }
  updated_at          { Time.now }
end
