# Telegrammer. Telegram bots manager application

![](https://img.shields.io/badge/ruby-v.3.1.1-red)

!Currently in production!

This application is based on https://github.com/telegram-bot-rb/telegram-bot gem and using Telegram API

Purposes of project:
- to create custom complex ruby application architecture from scratch without any frameworks (for education purposes)
- quick development and integration of multiple telegram bots in one application

To see example bot in action, please, telegram to @socialup_example_bot

![Framework console preview](https://user-images.githubusercontent.com/20019225/64276330-5c09f300-cf50-11e9-81dc-6a28ecd7cac1.JPG)
![Framework example bot preview](https://user-images.githubusercontent.com/20019225/64276329-5c09f300-cf50-11e9-9db2-fc871386fc72.jpg)


App includes:
- Database (Postgres), ActiveRecord ORM
- Key-value database (Redis) integration
- Background processing (Sidekiq) with web UI (SidekiqUI)
- Schedules for background workers (Sidekiq-scheduler)
- Background workers statistic (Sidekiq-statistic)
- Multiple environments (production, development, test)
- Docker-compose file to quickly run the whole app in isolation
- Console action logging (colorized for better readability)
- Prepared test environment (using RSpec by default)

## Requirements
Please keep in mind that you have to install `redis` and `postgres` on your local machine
Or just use included docker-compose file

## Preparation and obtaining an API key
First of all you need to create your own telegram bot and obtain an API key. Follow this steps, it's very simple and will take less than 5 mins:
1. Open telegram and find user '@botfather' in search
2. Press 'Start' button to begin conversation
3. Choose command '/newbot'
4. Enter desired name of your future bot (for instance 'SushiDeliveryBot')
5. Enter desired username (for instance 'sushi_delivery_bot')
6. Save obtained API key. You will set ENV variable with this key later
7. You should to set inline mode and turn off privacy mode for your bot. Inline mode will allow you to use inline keyboards and inline queries. Disabled privacy will allow you to sync user messages to DB. Find this settings in bot settings (@BotFather)

## Setup and first run (only using Docker compose)
1. Create .env file for dev environment: `cp .env.example .env.development`
2. Replace default ENV values, set bot token and username, set your own telegram user id
3. Run `docker-compose build`
4. Run `docker-compose run console bin/setup`
5. Run `docker-compose up`
6. Send to your telegram bot command `/enable` to set enabled state
7. Send `/start` and enjoy

## Available rake commands:
- `rake` - will run all spec tests
- `rake redis:flushall` - clear all Redis keys and values
- `rake bots:disable_all` - disable all bots (sets `enabled: false` in `bot_settings` table)
- `rake translations:check` - Check if all translations is imported to DB. It compares registered keys in `Translation` model with existing translation records in DB
- `rake db:new_migration name=create_some_table` - Generate migration file


## Run tests
Make sure you:
1. created `.env.test` file with proper ENV values
2. performed test DB migration: `docker-compose -f docker-compose.test.yml run console rake db:migrate RAILS_ENV=test`

- Use command `docker-compose -f docker-compose.test.yml run console rspec` to run all tests
- To run particular test use `docker-compose -f docker-compose.test.yml run console rspec ./spec/controllers/example_bot_controller_spec.rb`

## Deployment
Use `bin/deploy` script file to perform actions needed for project deployment

## Scripts
- `bin/console` to run console with preloaded codebase
- `bin/deploy` for performing deployment steps
- `bin/setup` to perform initial project setup

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/vrtsev/Telegrammer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License
The project is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct
Everyone interacting in the Telegrammer project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/vrtsev/Telegrammer/blob/master/CODE_OF_CONDUCT.md).
