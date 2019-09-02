Fabricator(:pdr_bot_auto_answer, from: 'PdrBot::AutoAnswer') do
  id                    { Fabricate.sequence(:pdr_bot_auto_answer, 1) }
  approved              { true }

  author_id             { |attrs| Fabricate(:pdr_bot_user).id }
  chat_id               { |attrs| Fabricate(:pdr_bot_chat).id }
  trigger               { Faker::Lorem.word }
  answer                { Faker::Lorem.word }

  created_at            { Time.now }
  updated_at            { Time.now }
end