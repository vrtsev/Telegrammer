Fabricator(:admin_bot_user, from: 'AdminBot::User') do
  id                  { Fabricate.sequence(:admin_bot_user, 1) }
  role                { ::AdminBot::User::Roles.not_approved }
  username            { Faker::Internet.username }
  first_name          { Faker::Name.first_name }
  last_name           { Faker::Name.last_name }

  created_at          { Time.now }
  updated_at          { Time.now }
end
