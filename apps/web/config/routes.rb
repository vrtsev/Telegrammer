Rails.application.routes.draw do
  root 'admin/dashboard#index'

  namespace :admin do
    resources :dashboard, only: :index

    namespace :jenia_bot do
      resources :messages
    end

    namespace :pdr_bot do
      resources :messages
    end
  end
end
