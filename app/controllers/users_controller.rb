class UsersController < ApplicationController
  helper_method :find_user

  def index
    @users = User.all
    @battle = Battle.find(7) # Nog aanpassen naar een param
    @members = @battle.users.each{ |u| u.id }
    @users = @users.where.not(id: @members.map{ |m| m.id })
    @users = @users.where("name LIKE ? AND id != ? ", "%#{params[:term]}%", @current_user.id).map{ |u| { label: u.name, value: u.id }} if params[:term].present?
    render json: @users
  end

  def new

  end

  def edit
    find_user
  end

  def update
    find_user
    if @user.update_attributes(user_params)
      redirect_to(root_path, :notice => 'Gebruiker is succesvol bijgewerkt.')
    else
      redirect_to :back
      flash[:notice] = "Er is iets fout gegaan."
    end
  end

  def show
    find_user
  end

  private

  def user_params
    params.require(:user).permit(:house_type, :family_size, :grade, :parental_approval, :company, :school, :birthday)
  end

  def find_user
    @user = User.find(params[:id])
  end
end