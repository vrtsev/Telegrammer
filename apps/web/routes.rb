# frozen_string_literal: false

WEB_APP = Hanami::Router.new do
  root to: Admin::DashboardController::Index

  namespace 'admin' do
    get '/', to: Admin::DashboardController::Index

    namespace :jenia_bot do
      namespace :messages do
        get 'new', to: Admin::JeniaBot::MessagesController::New
        post '/', to: Admin::JeniaBot::MessagesController::Create
      end
    end

    namespace :pdr_bot do
      namespace :messages do
        get 'new', to: Admin::PdrBot::MessagesController::New
        post '/', to: Admin::PdrBot::MessagesController::Create
      end
    end
  end
end
