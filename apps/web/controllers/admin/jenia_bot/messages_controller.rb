# frozen_string_literal: false

module Admin
  module JeniaBot
    module MessagesController
      class New < BaseAction
        include Hanami::Action

        def call(params)
          chats = ::JeniaBot::ChatRepository.new.all_desc
          render(Admin::JeniaBot::Messages::New, params: params, chats: chats)
        end
      end

      class Create < BaseAction
        include Hanami::Action

        def call(params)
          op_params = { text: params[:text], chat_id: params[:chat_id] }
          ::AdminBot::Op::JeniaBot::Message::SendFromBot.call(params: op_params)

          redirect_to("/admin/jenia_bot/messages/new?chat_id=#{params[:chat_id]}")
        end
      end
    end
  end
end
