class ApplicationController < ActionController::Base
  # before_action :authorize

  private

  def authorize
    unless @current_user
      redirect_to new_auth_session_path
    end
  end
end
