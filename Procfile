admin_bot: ruby ./bin/admin_bot APP_ENV=production
pdr_bot: ruby ./bin/pdr_bot APP_ENV=production
jenia_bot: ruby ./bin/jenia_bot APP_ENV=production
example_bot: ruby ./bin/example_bot APP_ENV=production

sidekiq: bundle exec sidekiq -t 25 -r ./config/boot.rb
sidekiqui: rackup apps/sidekiqui/config.ru -p 9393 --server=webrick