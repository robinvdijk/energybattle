class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user_is_host

  def current_user
    @current_user = User.first
  end

  def current_user_is_host
    @battle.host_id == @current_user.id
  end
end