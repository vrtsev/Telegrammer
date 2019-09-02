Fabricator(:pdr_bot_stat, from: 'PdrBot::Stat') do
  id                    { Fabricate.sequence(:pdr_bot_user, 1) }
  chat_id               { Fabricate(:pdr_bot_chat).id }
  user_id               { Fabricate(:pdr_bot_user).id }

  loser_count           { 0 }
  winner_count          { 0 }

  created_at            { Time.now }
  updated_at            { Time.now }
end
