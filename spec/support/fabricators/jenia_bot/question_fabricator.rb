Fabricator(:jenia_bot_question, from: 'JeniaBot::Question') do
  id                  { Fabricate.sequence(:jenia_bot_question, 1) }

  chat_id             { |attrs| Fabricate(:jenia_bot_chat).id }
  text                { Faker::Lorem.sentence }

  created_at          { Time.now }
  updated_at          { Time.now }
end