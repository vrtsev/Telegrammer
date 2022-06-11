# frozen_string_literal: true

module Helpers
  module Translation
    private

    def t(key, **params)
      ::Translation.for(key, **params.merge(chat_id: params[:chat_id]))
    end
  end
end
