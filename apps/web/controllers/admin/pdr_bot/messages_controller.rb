module Admin
  module PdrBot
    class MessagesController < ::AdminController
      get '/new' do
        @chats = ::PdrBot::ChatRepository.new.get_all_desc
        render_html 'admin/pdr_bot/messages/new'
      end

      post '/' do
        Telegram::BotManager::Message.new(
          ::PdrBot.bot, params[:message]
        ).send_to_chat(params[:chat_id])

        session[:flash] = { notice: "Message has been sent:\n #{params[:message]}" }
        redirect to("/new?chat_id=#{params[:chat_id]}")
      end
    end
  end
end
