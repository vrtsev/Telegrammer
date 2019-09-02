## Define your bot executable path
example_bot: ruby ./bin/example_bot APP_ENV=production

sidekiq: bundle exec sidekiq -t 25 -r ./config/boot.rb
sidekiqui: rackup apps/sidekiqui/config.ru -p 9393 --server=webrick