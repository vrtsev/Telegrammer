# frozen_string_literal: true

Telegram.bots_config = {
  pdr_bot: {
    token: ENV['PDR_BOT_API_TOKEN'],
    username: ENV['PDR_BOT_USERNAME'] # to support commands with mentions (/start@ChatBot)
  },
  jenia_bot: {
    token: ENV['JENIA_BOT_API_TOKEN'],
    username: ENV['JENIA_BOT_USERNAME'] # to support commands with mentions (/start@ChatBot)
  },
  example_bot: {
    token: ENV['EXAMPLE_BOT_API_TOKEN'],
    username: ENV['EXAMPLE_BOT_USERNAME'] # to support commands with mentions (/start@ChatBot)
  }
}
