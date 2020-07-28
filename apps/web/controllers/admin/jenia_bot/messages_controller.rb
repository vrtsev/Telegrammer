module Admin
  module JeniaBot
    class MessagesController < ::AdminController
      get '/new' do
        @chats = ::JeniaBot::ChatRepository.new.get_all_desc
        render_html 'admin/jenia_bot/messages/new'
      end

      post '/' do
        Telegram::BotManager::Message.new(
          ::JeniaBot.bot, params[:message]
        ).send_to_chat(params[:chat_id])

        session[:flash] = { notice: "Message has been sent:\n #{params[:message]}" }
        redirect to('/new')
      end
    end
  end
end
