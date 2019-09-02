Fabricator(:pdr_bot_chat_user, from: 'PdrBot::ChatUser') do
  id                    { Fabricate.sequence(:pdr_bot_message, 1) }
  user_id               { Fabricate(:pdr_bot_user).id }
  chat_id               { Fabricate(:pdr_bot_chat).id }

  created_at            { Time.now }
  updated_at            { Time.now }
end