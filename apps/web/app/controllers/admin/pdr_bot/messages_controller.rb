module Admin
  module PdrBot
    class MessagesController < AdminController
      def new
        @chats = ::PdrBot::ChatRepository.new.get_all_desc
      end

      def create
        op_params = { text: params[:text], chat_id: params[:chat_id] }
        result = ::AdminBot::Op::PdrBot::Message::SendFromBot.call(params: op_params)

        flash[:error] = 'Something went wrong' unless result.success?
        redirect_to new_admin_pdr_bot_message_path(chat_id: params[:chat_id])
      end
    end
  end
end
