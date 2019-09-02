# Fabricator(:my_bot_auto_answer, from: 'MyBot::AutoAnswer') do
#   id                  { Fabricate.sequence(:my_bot_auto_answer, 1) }
#   approved            { true }
#   author_id           { |attrs| Fabricate(:my_bot_user).id }
#   chat_id             { |attrs| Fabricate(:my_bot_chat).id }
#   trigger             { Faker::Lorem.word }
#   answer              { Faker::Lorem.word }

#   created_at          { Time.now }
#   updated_at          { Time.now }
# end