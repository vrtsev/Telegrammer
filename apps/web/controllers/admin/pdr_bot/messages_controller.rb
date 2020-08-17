# frozen_string_literal: false

module Admin
  module PdrBot
    module MessagesController
      class New < BaseAction
        include Hanami::Action

        def call(params)
          chats = ::PdrBot::ChatRepository.new.all_desc
          render(Admin::PdrBot::Messages::New, params: params, chats: chats)
        end
      end

      class Create < BaseAction
        include Hanami::Action

        def call(params)
          op_params = { text: params[:text], chat_id: params[:chat_id] }
          ::AdminBot::Op::PdrBot::Message::SendFromBot.call(params: op_params)

          redirect_to("/admin/pdr_bot/messages/new?chat_id=#{params[:chat_id]}")
        end
      end
    end
  end
end
