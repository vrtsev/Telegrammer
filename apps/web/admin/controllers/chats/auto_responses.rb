# frozen_string_literal: true

Web::Admin.controllers :auto_responses, parent: :chats do
  before do
    @chat = Chat.find(params[:chat_id])
  end

  get '/', name: :index do
    @chats = chats_scope

    render 'chats/auto_responses/index'
  end

  post '/', name: :create, params: [:bot, :trigger, :response] do
    author = User.find_by(external_id: ENV['TELEGRAM_APP_OWNER_ID'])
    @chat.auto_responses.create!(
      bot_id: Bot.find_by(name: params[:bot]).id,
      trigger: params[:trigger],
      response: params[:response],
      author_id: author.id
    )

    redirect url(:auto_responses, :index, chat_id: @chat.id)
  end

  delete '/:id', name: :destroy do
    @chat.auto_responses.find(params[:id]).destroy!

    redirect url(:auto_responses, :index, chat_id: @chat.id)
  end
end
