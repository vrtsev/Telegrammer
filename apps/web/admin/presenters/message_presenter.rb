# frozen_string_literal: true

class MessagePresenter < BasePresenter
  def outgoing_class
    'outgoing-message' if outgoing?
  end

  def outgoing?
    @object.user.is_bot?
  end

  def last_viewed?(last_viewed_message_id)
    @object.id == last_viewed_message_id
  end
end
