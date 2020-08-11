# Telegram bot manager application

Purposes of project:
- To create custom complex ruby application architecture from scratch without any frameworks (for education purposes)
- To create application with useful bots inside

Advanced application with multiple telegram bots inside
Purpose of this project - quick development and integration multiple telegram bots in one application

To see example bot in action, please, telegram to @socialup_example_bot

![Framework console preview](https://user-images.githubusercontent.com/20019225/64276330-5c09f300-cf50-11e9-81dc-6a28ecd7cac1.JPG)
![Framework example bot preview](https://user-images.githubusercontent.com/20019225/64276329-5c09f300-cf50-11e9-9db2-fc871386fc72.jpg)

This application is based on:
- https://github.com/telegram-bot-rb/telegram-bot gem and using Telegram API
- https://github.com/vrtsev/telegram-bot-manager-ruby gem as a wrapper for `telegram-bot` gem with advanced instruments
- https://github.com/vrtsev/telegram-app-manager-framework and follows architecture conventions for quick bot development and integration

App includes out-of-the-box:
- Database (Postgres), ORM and migrations (Sequel)
- Key-value database (Redis)
- Background processing (Sidekiq) with web UI (SidekiqUI)
- Schedules for background workers (Sidekiq-scheduler)
- Background Workers statistic (Sidekiq-statistic)
- multiple environments (production, development, test)
- Rake tasks for general tasks such as migrate db etc..
- Docker-compose file to quickly run the whole app in isolation
- Console action logging (colorized for better readability)
- Locales that contains your telegram message parts and can be easily changed to other locale file
- Prepared test environment (using RSpec by default)
- Trailblazer-operation gem by default to write service objects with business logic

## Requirements
Please keep in mind that you have to install `redis` and `postgres` on your local machine
Or just use docker. Docker-compose file included

## Preparation and obtaining an API key
First of all you need to create your own telegram bot and obtain an API key. Follow this steps, it's very simple and will take less than 5 mins:
1. Open telegram and find user '@botfather' in search
2. Press 'Start' button to begin conversation
3. Choose command '/newbot'
4. Enter desired name of your future bot (for instance 'SushiDeliveryBot')
5. Enter desired username (for instance 'sushi_delivery_bot')
6. Save obtained API key. You will set ENV variable with this key later
7. You should to set inline mode and turn off privacy mode for your bot. Inline mode will allow you to use inline keyboards and inline queries. Disabled privacy will allow you to sync user messages to DB. Find this settings in bot settings (@BotFather)

## Setup and first run
1. Create a copy of `.env.example` file and name it `.env`
2. Open `.env` file and set ENV variables

```
# Telegram settings
# (write to '@get_any_telegram_id_bot' if you dont know your id)
TELEGRAM_APP_OWNER_ID= /insert your personal telegram id/
```

4. Run command `bin/setup`
5. Run `bin/%bot_bin_file% to start bot
6. Write `/start` message to your bot in telegram and see output in console

## Run using docker-compose
```
$ docker-compose build
$ docker-compose run application bin/setup
$ docker-compose up
```

## Available rake commands:
- `rake` - will run all spec tests
- `rake SPEC='spec/admin_bot/controller_spec.rb'` - run specified spec test
- `rake redis:flushall` - clear all Redis keys and values
- `rake db:create` - create DB in Postgres
- `rake db:prepare_for_test` - Create and migrate DB for test env
- `rake db:drop` - drop database that specified in `ENV['POSTGRES_DB']` variable
- `rake db:version` - current migration version
- `rake db:migrate` - migrate DB
- `rake db:rollback` - rollback to previous migration version
- `rake db:clear` - clear all data in DB
- `rake db:seed` - seed DB with example test data for development env


## Adding new locales
Add new locales to '/locales' folder. Keep in mind, that everything except '/locales/en' folder will be hidden from git (see .gitignore file)

## Deployment
Use `bin/deploy` script file to perform actions needed for project deployment

## Scripts
- `bin/console` to run console with preloaded codebase
- `bin/deploy` for performing deployment steps
- `bin/setup` to perform initial project setup


## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/vrtsev/SocialUp. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct
Everyone interacting in the AppManager project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/vrtsev/SocialUp/blob/master/CODE_OF_CONDUCT.md).
