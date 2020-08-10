Rails.application.routes.draw do
  root 'home#index'

  namespace :auth do
    resource :session, only: %i[new create]
  end

  namespace :admin do
    resources :dashboard, only: :index

    namespace :jenia_bot do
      resources :auto_answers
      resources :questions
      resources :messages
    end

    namespace :pdr_bot do
      resources :messages
    end
  end
end
