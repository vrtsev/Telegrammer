# frozen_string_literal: true

class ChatPresenter < BasePresenter
  include Avatar

  def avatar_background_class
    case @object.chat_type
    when 'private_chat' then 'bg-info'
    when 'group_chat' then 'bg-success'
    when 'supergroup' then 'bg-warning'
    when 'channel' then 'bg-danger'
    end
  end

  def opened_class(chat_id)
    'open-chat' if opened?(chat_id)
  end

  def opened?(chat_id)
    @object.id == chat_id.to_i
  end

  def unread_messages
    last_viewed_message_id = Web::App.cache["chats:#{@object.id}:last_viewed_message_id"]

    return if last_viewed_message_id.blank?
    @object.messages.reject do |message|
      message.id <= last_viewed_message_id
    end
  end
end
