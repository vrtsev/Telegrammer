# frozen_string_literal: false

Fabricator(:admin_bot_message, from: 'AdminBot::Message') do
  id                  { Fabricate.sequence(:admin_bot_message, 1) }
  text                { Faker::Lorem.sentence }

  created_at          { Time.now }
  updated_at          { Time.now }
end
