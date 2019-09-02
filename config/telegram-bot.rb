Telegram.bots_config = {
  admin_bot: {
    token: ENV['ADMIN_BOT_API_TOKEN'],
    username: ENV['ADMIN_BOT_USERNAME'] # to parse command with mention
  },

  pdr_bot: {
    token: ENV['PDR_BOT_API_TOKEN'],
    username: ENV['PDR_BOT_USERNAME'] # to parse command with mention
  },

  jenia_bot: {
    token: ENV['JENIA_BOT_API_TOKEN'],
    username: ENV['JENIA_BOT_USERNAME'] # to parse command with mention
  },

  example_bot: {
    token: ENV['EXAMPLE_BOT_API_TOKEN'],
    username: ENV['EXAMPLE_BOT_USERNAME'] # to parse command with mention
  },
}