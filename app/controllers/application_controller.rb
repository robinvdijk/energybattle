class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_signin, :check_notifications

  helper_method :current_user_is_host

  def check_signin
    unless user_signed_in? == true
      redirect_to root_path
      flash[:notice] = "Login om deze pagina te bezoeken"
    end
  end

  def check_notifications
    unless user_signed_in? == false
      @count_notifications = current_user.notifications.count
    end
  end

  def current_user_is_host
    @battle.host_id == @current_user.id
  end
end
