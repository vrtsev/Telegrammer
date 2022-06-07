# frozen_string_literal: true

Web::Admin.controllers :chats do
  get '/', name: :index do
    redirect url(:chats, :show, id: chats_scope.first.id)
  end

  get '/:id', name: :show do
    redirect url(:messages, :index, chat_id: params[:id])
  end
end
