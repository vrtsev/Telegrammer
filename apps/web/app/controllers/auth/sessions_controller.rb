module Auth
  class SessionsController < AuthController
    def new
    end

    def create
      binding.pry
      # user = ::AdminBot::UserRepository.new.find_by_login(params[:login])

      # if user
      #   otp = ROTP::TOTP.new(user.otp_secret, interval: 30, issuer: 'lala').now
      #   session[:user_id] = user.id
      #   Telegram::BotManager::Message.new(
      #     ::AdminBot.bot, 'Here is your code for auth: ' + otp
      #   ).send_to_chat(user.id)

      #   redirect to('/login_confirmation')
      # else
      #   session[:flash] = { error: 'User not found. Make sure that your data is correct and you already interacted with bot' }
      #   redirect to('/login')
      # end
    end
  end
end
