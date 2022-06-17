# frozen_string_literal: true

Web::Admin.controllers :pdr_game_rounds, parent: :chats do
  before do
    @chat = Chat.find(params[:chat_id])
  end

  delete '/:id', name: :destroy do
    service_params = { chat_id: @chat.id, pdr_game_round_id: params[:id] }
    PdrGame::Rounds::Rollback.call(service_params)

    redirect url(:messages, :index, chat_id: @chat.id)
  end
end
