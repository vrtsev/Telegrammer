# frozen_string_literal: false

Fabricator(:pdr_bot_user, from: 'PdrBot::User') do
  id                    { Fabricate.sequence(:pdr_bot_user, 1) }
  username              { Faker::Internet.username }
  first_name            { Faker::Name.first_name }
  last_name             { Faker::Name.last_name }

  created_at            { Time.now }
  updated_at            { Time.now }
end
