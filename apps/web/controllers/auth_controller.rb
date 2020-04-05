class AuthController < ::ApplicationController
  set :erb, layout: :'layouts/auth'

  get '/login' do
    render_html 'auth/login'
  end

  post '/login' do
    user = ::AdminBot::UserRepository.new.find_by_login(params[:login])

    if user
      otp = ROTP::TOTP.new(user.otp_secret, interval: 30, issuer: 'lala').now
      session[:user_id] = user.id
      Telegram::BotManager::Message.new(
        ::AdminBot.bot, 'Here is your code for auth: ' + otp
      ).send_to_chat(user.id)

      redirect to('/login_confirmation')
    else
      session[:flash] = { error: 'User not found. Make sure that your data is correct and you already interacted with bot' }
      redirect to('/login')
    end
  end

  get '/login_confirmation' do
    render_html 'auth/login_confirmation'
  end

  post '/login_confirmation' do
    user = ::AdminBot::UserRepository.new.find(session[:user_id])

    if user
      otp = ROTP::TOTP.new(user.otp_secret, interval: 30, issuer: 'lala')

      if otp.verify(params[:login_code], drift_behind: 30)
        payload = { user_id: user.id }
        token = JWT.encode payload, nil, 'none'
        login_user(token)
        session[:user_id] = nil
        redirect '/admin/dashboard'
      else
        session[:flash] = { error: 'Code not valid. Return back and try again' }
        redirect to('/login_confirmation')
      end
    else
      redirect to('/login')
    end
  end

  get '/logout' do
    logout_user
    session[:flash] = { notice: 'Logged out successfully' }
    redirect '/'
  end
end
