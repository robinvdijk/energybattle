class UsersController < ApplicationController
  respond_to :html, :json

  def index
    @users = User.all
    @users = @users.where("name LIKE ?", "%#{params[:term]}%").pluck(:name) if params[:term].present?
    respond_with @users
  end

  def new

  end

  def show
  	@user = User.find(params[:id])
  end
end