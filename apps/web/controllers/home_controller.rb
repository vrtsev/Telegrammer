class HomeController < ApplicationController
  get '/' do
    erb :'home/index'
  end
end
