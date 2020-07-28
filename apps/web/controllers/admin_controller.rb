class AdminController < ApplicationController
  set :erb, layout: :'layouts/admin'

  before('/') do
    authorize

    unless authorized?
      session[:flash] = { error: 'You do not have right to visit this page' }
      redirect '/'
    end
  end
end