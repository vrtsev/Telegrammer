# frozen_string_literal: true

Web::App.controllers :base do
  get '/', name: :index do
    redirect to '/admin'
  end
end
