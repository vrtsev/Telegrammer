module Admin
  module JeniaBot
    class MessagesController < AdminController
      def new
        @chats = ::JeniaBot::ChatRepository.new.all_desc
      end

      def create
        op_params = { text: params[:text], chat_id: params[:chat_id] }
        result = ::AdminBot::Op::JeniaBot::Message::SendFromBot.call(params: op_params)

        flash[:error] = 'Something went wrong' unless result.success?
        redirect_to new_admin_jenia_bot_message_path(chat_id: params[:chat_id])
      end
    end
  end
end
