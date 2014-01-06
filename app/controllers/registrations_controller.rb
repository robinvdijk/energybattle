class RegistrationsController < Devise::RegistrationsController
 
  # def create
  #   if session[:provider] == 'facebook'
  #     params['user']['confirmed_at'] = Time.now
  #   end
  #   super
  #   if session[:provider] == 'facebook'
  #     sign_in(:user, @user)  
  #   end
  # end


  def new
  	super
  end

  def create
  	super
  end	

  def edit
    super
  end

  def update
  	@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:succes] = "Uw wijzigingen zijn opgeslagen."
      redirect_to root_path
    else
      flash[:error] = "Er is iets mis gegaan. Probeer het opnieuw."
    end
  end
end