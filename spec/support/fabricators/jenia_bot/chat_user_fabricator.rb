# frozen_string_literal: false

Fabricator(:jenia_bot_chat_user, from: 'JeniaBot::ChatUser') do
  id                  { Fabricate.sequence(:jenia_bot_message, 1) }
  user_id             { Fabricate(:jenia_bot_user).id }
  chat_id             { Fabricate(:jenia_bot_chat).id }

  created_at          { Time.now }
  updated_at          { Time.now }
end
