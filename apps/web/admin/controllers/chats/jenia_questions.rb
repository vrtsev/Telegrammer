# frozen_string_literal: true

Web::Admin.controllers :jenia_questions, parent: :chats do
  before do
    @chat = Chat.find(params[:chat_id])
  end

  post '/', name: :create, params: [:text] do
    @chat.jenia_questions.create!(text: params[:text])

    redirect url(:messages, :index, chat_id: @chat.id)
  end

  delete '/:id', name: :destroy do
    @chat.jenia_questions.find(params[:id]).destroy!

    redirect url(:messages, :index, chat_id: @chat.id)
  end
end
