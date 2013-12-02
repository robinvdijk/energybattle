class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :logged_in?

  def logged_in?
    unless user_signed_in?
      redirect_to root_path
      flash[:notice] = "Login om deze pagina te bezoeken"
    end
  end
end
