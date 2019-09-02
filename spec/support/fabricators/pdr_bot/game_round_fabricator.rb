Fabricator(:pdr_bot_game_round, from: 'PdrBot::GameRound') do
  id                    { Fabricate.sequence(:pdr_bot_user, 1) }
  chat_id               { Fabricate(:pdr_bot_chat).id }

  initiator_id          { Fabricate(:pdr_bot_chat_user).id }
  loser_id              { Fabricate(:pdr_bot_chat_user).id }
  winner_id             { Fabricate(:pdr_bot_chat_user).id }

  created_at            { Time.now }
  updated_at            { Time.now }
end
