class ApplicationController < ::Application
  set :erb, layout: :'layouts/default'

  before('/') do
    authorize

    unless authorized?
      session[:flash] = { error: 'Please, login into system' }
      redirect '/auth/login'
    end
  end

  private

  def authorize
    unless cookies[:jwt].blank?
      decoded_token = JWT.decode cookies[:jwt], nil, false
      user_data = decoded_token.find {|e| e.keys.include? 'user_id'}

      @current_user = ::AdminBot::User.find(user_data['user_id']).first
      @authorized = true
    end
  end

  def authorized?
    @authorized || false
  end

  def login_user(token)
    cookies[:jwt] = token

    @authorized = true
    @current_user = ::AdminBot::User.find(1)
  end

  def logout_user
    cookies[:jwt] = nil

    @authorized = false
    @current_user = nil
  end

  def render_html(path)
    erb path.to_sym
  end
end
