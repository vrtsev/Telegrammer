example_bot_translations = [
  { key: :'example_bot.command_exception', values: ['Error. We are working on this issue'] },
  { key: :'example_bot.auto_response',     values: ['Received message: %{message}', 'Got: %{message}'] },
  { key: :'example_bot.start_message',     values: [<<~TEXT
      Example Telegram Bot (author @vadimrb)
      Repository: https://github.com/vrtsev/Telegrammer
      Available commands:
      /start - show this message

      Write message: 'Hello bot' and you will see autoanswer
    TEXT
  ]}
]

jenia_bot_translations = [
  { key: :'jenia_bot.command_exception', values: ['Now now', 'Noo', 'Later...'] },
  { key: :'jenia_bot.default_call_answer', values: ['I am here', 'Who is calling me'] },
  { key: :'jenia_bot.start_message', values: [<<~TEXT
      Hi, it is a JeniaBot!
      Call a command /jenia and I will show you a list with questions
      Ask me a question and I will show you the answer!
    TEXT
  ]}
]

pdr_bot_translations = [
  { key: :'pdr_bot.command_exception', values: ['Something went wrong', 'Error. We are working on this issue'] },
  { key: :'pdr_bot.start_message', values: [<<~TEXT
      Hi, it is a PdrBot. I will let you know who is the winner and loser of the day

      Here is an instructions:

      /pdr - run game
      /results - show latest result
      /stats - show chat stats

      Author: @vadimrb
    TEXT
  ]},
  { key: :'pdr_bot.game.start.title',                      values: ['Lets see who is a leaders of the day', 'Searching for the leaders'] },
  { key: :'pdr_bot.game.start.searching_users',            values: ['Here it is!!!', 'Ok, I have results'] },
  { key: :'pdr_bot.game.reminder',                         values: ['Lets start the game: /pdr'] },
  { key: :'pdr_bot.game.errors.latest_round_not_expired',  values: ['We’ve already launched the game today ... Be careful. Run the results command (like /results)', 'Loser has been already found. Run /results command'] },
  { key: :'pdr_bot.game.errors.not_enough_users',          values: ['No no, for the game I need more than %{min_count} registered people. The more people will write to chat - the more will be registered. Keep in mind game is available only in group chats'] },
  { key: :'pdr_bot.game.errors.stats_not_found',           values: ['There is not statistics yet. Run at least a game, or wait until enough players will be registered'] },
  { key: :'pdr_bot.game.errors.no_rounds',                 values: ['There is no game rounds. Run command "/pdr" to know who is a leaders of the day'] },

  { key: :'pdr_bot.game.results.title',                    values: ['Here is stats:', 'We decided that:'] },
  { key: :'pdr_bot.game.results.loser',                    values: ['💩 loser is %{user_name}...', '💩 %{user_name} is loser today...'] },
  { key: :'pdr_bot.game.results.winner',                   values: ['😎 And winner is.... %{user_name}', '😎 The best is %{user_name} today!'] },

  { key: :'pdr_bot.game.stats.leaders.title',              values: ['The best of the best:', 'Leaders:'] },
  { key: :'pdr_bot.game.stats.leaders.winner',             values: ['😎 Max winner is %{user_name} (%{count} times)', '😎 Here is a winner %{user_name}. You was the best (%{count} times)'] },
  { key: :'pdr_bot.game.stats.leaders.loser',              values: ['💩 Max loser %{user_name} (%{count} times)', '💩 Bad user %{user_name} (%{count} times)'] },
  { key: :'pdr_bot.game.stats.chat_user_stat',             values: ['💩 x%{loser_count} / 😎 x%{winner_count} :: %{user_name}'] },
]

Translation.create(example_bot_translations)
Translation.create(jenia_bot_translations)
Translation.create(pdr_bot_translations)
