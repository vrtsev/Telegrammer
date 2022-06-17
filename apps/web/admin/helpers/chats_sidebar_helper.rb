# frozen_string_literal: true

Web::Admin.helpers do
  def chats_scope
    Chat.select('chats.*, MAX(messages.created_at) AS recent_message_date')
        .joins(:messages).order('recent_message_date DESC')
        .group('chats.id')
  end
end
