class ApplicationController < ActionController::Base
  # before_action :authorize

  private

  def authorize
    unless session[:user_id]
      redirect_to new_auth_session_path
    end
  end
end
