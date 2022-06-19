# frozen_string_literal: true

module Helpers
  module Translation
    private

    def t(key, **params)
      chat_id = self.respond_to?(:current_chat) ? current_chat&.id : params[:chat_id]

      ::Translation.for(key, **params.merge(chat_id: chat_id))
    end
  end
end
