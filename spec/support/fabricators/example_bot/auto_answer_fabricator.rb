# frozen_string_literal: false

Fabricator(:example_bot_auto_answer, from: 'ExampleBot::AutoAnswer') do
  id                  { Fabricate.sequence(:example_bot_auto_answer, 1) }
  approved            { true }
  author_id           { |_attrs| Fabricate(:example_bot_user).id }
  chat_id             { |_attrs| Fabricate(:example_bot_chat).id }
  trigger             { Faker::Lorem.word }
  answer              { Faker::Lorem.word }

  created_at          { Time.now }
  updated_at          { Time.now }
end
