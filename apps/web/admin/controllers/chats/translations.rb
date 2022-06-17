# frozen_string_literal: true

Web::Admin.controllers :translations, parent: :chats do
  before do
    @chat = Chat.find(params[:chat_id])
  end

  get '/', name: :index do
    @chats = chats_scope

    render 'chats/translations/index'
  end
end
