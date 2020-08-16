Fabricator(:jenia_bot_message, from: 'JeniaBot::Message') do
  id                  { Fabricate.sequence(:jenia_bot_message, 1) }
  chat_id             { |attrs| Fabricate(:jenia_bot_chat).id }
  user_id             { |attrs| Fabricate(:pdr_bot_user).id }
  text                { Faker::Lorem.sentence }

  created_at          { Time.now }
  updated_at          { Time.now }
end