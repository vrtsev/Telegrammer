# frozen_string_literal: true

Web::Admin.controllers :base do
  get '/', name: :index do
    redirect url(:chats, :index)
  end
end
