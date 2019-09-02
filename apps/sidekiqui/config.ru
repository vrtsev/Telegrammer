require './config/environment.rb'

use Rack::Auth::Basic, "Authentication required" do |username, password|
  username == ENV['HTTP_USER']  &&
  password == ENV['HTTP_PASSWORD']
end

Sidekiq::Web.set(:sessions, { key: 'rack.session.sidekiqui', path: '/' })

run Sidekiq::Web
