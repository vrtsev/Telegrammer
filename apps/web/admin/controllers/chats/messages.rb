# frozen_string_literal: true

Web::Admin.controllers :messages, parent: :chats do
  before do
    @chat = Chat.find(params[:chat_id])
  end

  before :index, :reply, :edit do
    @chats = chats_scope
    @messages = @chat.messages.order(id: :asc).last(300)

    @last_viewed_message_id = Web::App.cache["chats:#{@chat.id}:last_viewed_message_id"]
    Web::App.cache["chats:#{@chat.id}:last_viewed_message_id"] = @messages.last.id
  end

  before :reply, :edit, :create, :update, :destroy do
    @message = Message.find(params[:id]) if params[:id]
  end

  get '/', name: :index do
    render 'chats/messages/index'
  end

  get '/:id/reply', name: :reply do
    render 'chats/messages/reply'
  end

  get '/:id/edit', name: :edit do
    render 'chats/messages/edit'
  end

  post '/', name: :create, params: [:bot, :text] do
    service_params = {
      chat_id: @chat.id,
      bot: params[:bot].to_sym,
      text: params[:text],
      reply_to_message_id: @message&.id
    }

    result = Messages::Send.call(service_params)
    flash[:message_error] = result.exception.error_code unless result.success?

    redirect url(:messages, :index, chat_id: @chat.id)
  end

  patch '/:id', name: :update, params: [:bot, :text] do
    service_params = {
      chat_id: @chat.id,
      bot: params[:bot].to_sym,
      text: params[:text],
      edit_message_id: @message.id
    }

    result = Messages::Edit.call(service_params)
    flash[:message_error] = result.exception.error_code unless result.success?

    redirect url(:messages, :index, chat_id: @chat.id, bot: params[:bot])
  end

  delete '/:id', name: :destroy do
    service_params = { chat_id: @chat.id, message_id: params[:id] }

    result = Messages::Delete.call(service_params)
    flash[:message_error] = result.exception.error_code unless result.success?

    redirect url(:messages, :index, chat_id: @chat.id, bot: params[:bot])
  end
end
