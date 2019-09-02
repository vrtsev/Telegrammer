## Define your bot executable path
my_bot: ruby ./bin/my_bot APP_ENV=production

sidekiq: bundle exec sidekiq -t 25 -r ./config/boot.rb
sidekiqui: rackup apps/sidekiqui/config.ru -p 9393 --server=webrick