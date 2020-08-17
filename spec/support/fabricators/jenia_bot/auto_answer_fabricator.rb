# frozen_string_literal: false

Fabricator(:jenia_bot_auto_answer, from: 'JeniaBot::AutoAnswer') do
  id                  { Fabricate.sequence(:jenia_bot_auto_answer, 1) }
  approved            { true }
  author_id           { |_attrs| Fabricate(:jenia_bot_user).id }
  chat_id             { |_attrs| Fabricate(:jenia_bot_chat).id }
  trigger             { Faker::Lorem.word }
  answer              { Faker::Lorem.word }

  created_at          { Time.now }
  updated_at          { Time.now }
end
