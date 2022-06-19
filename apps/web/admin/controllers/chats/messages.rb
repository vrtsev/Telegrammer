# frozen_string_literal: true

Web::Admin.controllers :messages, parent: :chats do
  DEFAULT_MESSAGES_COUNT_LIMIT = 300

  before do
    @chat = Chat.find(params[:chat_id])
  end

  before :index, :reply, :edit do
    @chats = chats_scope
    @available_bots = Bot.joins(user: :chat_users).where(chat_users: { chat_id: @chat.id, deleted_at: nil })
    @messages = @chat.messages.order(id: :asc).last(params[:limit] || DEFAULT_MESSAGES_COUNT_LIMIT)

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
    bot = Bot.find_or_create_by(name: params[:bot])
    sync_bot_user(bot)

    message_params = {
      bot_id: bot.id,
      chat_id: @chat.id,
      text: params[:text],
      message_id: @message&.id
    }
    service = @message.present? ? Messages::Reply : Messages::Create
    result = service.call(message_params)
    flash[:message_error] = result.exception.error_code unless result.success?

    redirect url(:messages, :index, chat_id: @chat.id)
  end

  patch '/:id', name: :update, params: [:bot, :text] do
    bot = Bot.find_or_create_by(name: params[:bot])
    sync_bot_user(bot)

    message_params = {
      bot_id: bot.id,
      chat_id: @chat.id,
      text: params[:text],
      message_id: @message.id
    }

    result = Messages::Edit.call(message_params)
    flash[:message_error] = result.exception.error_code unless result.success?

    redirect url(:messages, :index, chat_id: @chat.id, bot: params[:bot])
  end

  delete '/:id', name: :destroy do
    bot = @message.bot
    sync_bot_user(bot)

    message_params = {
      bot_id: bot.id,
      chat_id: @chat.id,
      message_id: @message.id
    }

    result = Messages::Delete.call(message_params)
    flash[:message_error] = result.exception.error_code unless result.success?

    redirect url(:messages, :index, chat_id: @chat.id, bot: params[:bot])
  end
end
