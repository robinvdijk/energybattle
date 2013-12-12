class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :logged_in?

  def logged_in?
    unless user_signed_in?
      redirect_to root_path
<<<<<<< HEAD
      flash[:notice] = "Log in om deze pagina te bezoeken"
=======
      flash[:notice] = "Login om deze pagina te bezoeken"
>>>>>>> b1d18294718c3f3b790b44c30d8ca846691cb65d
    end
  end
end
