# frozen_string_literal: true

require_relative 'seeds/translations.rb'

# Bot Settings
BotSetting.create(bot: Telegram.bots[:example_bot], enabled: true, autoapprove_chat: true)
BotSetting.create(bot: Telegram.bots[:jenia_bot], enabled: true, autoapprove_chat: true)
BotSetting.create(bot: Telegram.bots[:pdr_bot], enabled: true, autoapprove_chat: true)

# Users
user1 = User.create(external_id: ENV['TELEGRAM_APP_OWNER_ID'], username: "admin", first_name: "Admin", last_name: nil)
user2 = User.create(external_id: 1234567, username: nil, first_name: "Chat user", last_name: nil)

# Chats
chat1 = Chat.create(external_id: ENV['TELEGRAM_APP_OWNER_ID'], approved: true, chat_type: "private_chat", title: nil, username: "admin", first_name: "Admin")
chat2 = Chat.create(external_id: 987654321, approved: true, chat_type: "group_chat", title: "Test group")

# ChatUsers
chat_user1 = ChatUser.create(chat: chat1, user: user1)
chat_user2 = ChatUser.create(chat: chat1, user: user2)
chat_user3 = ChatUser.create(chat: chat2, user: user1)

# Stats
PdrGame::Stat.create(chat_user: chat_user1, loser_count: 1, winner_count: 2)
PdrGame::Stat.create(chat_user: chat_user2, loser_count: 2, winner_count: 1)

# Rounds
PdrGame::Round.create(chat: chat1, initiator_id: user1, winner_id: user1, loser_id: user2)

# AutoResponses
AutoResponse.create(bot: :example_bot, author: user1, chat: chat1, trigger: 'Are you here?', response: 'I am here')
AutoResponse.create(bot: :example_bot, author: user1, chat: chat1, trigger: 'Hey bot', response: '??')

AutoResponse.create(bot: :jenia_bot,   author: user1, chat: chat1, trigger: 'Jenia', response: 'Who is calling me?')
AutoResponse.create(bot: :jenia_bot,   author: user1, chat: chat2, trigger: 'Jenia', response: 'Who is calling me?')
AutoResponse.create(bot: :jenia_bot,   author: user1, chat: chat1, trigger: 'How are you?', response: 'I am ok')
AutoResponse.create(bot: :jenia_bot,   author: user1, chat: chat2, trigger: 'How are you?', response: 'I am ok')

AutoResponse.create(bot: :pdr_bot,     author: user1, chat: chat1, trigger: 'hey', response: 'Who are you?')
AutoResponse.create(bot: :pdr_bot,     author: user1, chat: chat2, trigger: 'hey', response: 'Who are you?')

# JeniaQuestions
JeniaQuestion.create(chat: chat1, text: 'Jenia, how are you?')
JeniaQuestion.create(chat: chat2, text: 'Jenia, how are you?')
JeniaQuestion.create(chat: chat1, text: 'Jenia, wazzup?')
JeniaQuestion.create(chat: chat2, text: 'Jenia, wazzup?')