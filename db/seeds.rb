# frozen_string_literal: true

require_relative 'seeds/translations.rb'

# Bots
example_bot = Bot.create!(name: 'example_bot', username: ENV['EXAMPLE_BOT_USERNAME'], enabled: false, autoapprove_chat: true)
jenia_bot = Bot.create!(name: 'jenia_bot', username: ENV['JENIA_BOT_USERNAME'], enabled: false, autoapprove_chat: true)
pdr_bot = Bot.create!(name: 'pdr_bot', username: ENV['PDR_BOT_USERNAME'], enabled: false, autoapprove_chat: true)

# Users
user1 = User.create!(external_id: ENV['TELEGRAM_APP_OWNER_ID'], username: "admin", first_name: "Admin", last_name: nil)

# Chats
chat1 = Chat.create!(external_id: ENV['TELEGRAM_APP_OWNER_ID'], approved: true, chat_type: "private_chat", title: nil, username: "admin", first_name: "Admin")

# ChatUsers
chat_user1 = ChatUser.create!(chat: chat1, user: user1)

# Messages
Message.create!(chat_user_id: chat_user1.id, payload_type: 'text', external_id: 10001, text: 'Private chat message', bot_id: example_bot.id)

# AutoResponses
AutoResponse.create!(bot_id: example_bot.id, author: user1, chat: chat1, trigger: 'Hey example bot', response: 'Example bot is here')
AutoResponse.create!(bot_id: example_bot.id, author: user1, chat: chat1, trigger: 'Example bot how are you', response: 'Example bot is ok')

AutoResponse.create!(bot_id: pdr_bot.id,     author: user1, chat: chat1, trigger: 'Hey pdr bot', response: 'Pdr bot is here')
AutoResponse.create!(bot_id: pdr_bot.id,     author: user1, chat: chat1, trigger: 'Pdr bot how are you', response: 'Pdr bot is ok')

jenia_bot_response1 = AutoResponse.create!(bot_id: jenia_bot.id,   author: user1, chat: chat1, trigger: 'Hey jenia bot', response: 'Jenia bot is here')
jenia_bot_response2 = AutoResponse.create!(bot_id: jenia_bot.id,   author: user1, chat: chat1, trigger: 'Jenia bot how are you', response: 'Jenia bot is ok')

# JeniaQuestions
JeniaQuestion.create!(chat: chat1, text: jenia_bot_response1.trigger)
JeniaQuestion.create!(chat: chat1, text: jenia_bot_response2.trigger)