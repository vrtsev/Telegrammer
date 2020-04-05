class Application < Sinatra::Base
  helpers Sinatra::Cookies
  enable :sessions
  set :root, File.expand_path('.', 'apps/web')
  set :environment, APP_ENV
  set :cookie_options, path: '/'
  set :logging, true
  set :views, File.join(settings.root, '/views')

  if  APP_ENV != :production
    set :session_secret, 'secret_code'
  end

  helpers do
    def flash
      @flash = session.delete(:flash)
    end

    def current_user
      @current_user
    end
  end
end