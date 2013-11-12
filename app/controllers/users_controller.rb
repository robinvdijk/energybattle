class UsersController < ApplicationController
  respond_to :html, :json

  def index
    @users = User.all
    @users = @users.where("first_name LIKE ?", "%#{params[:term]}%").pluck(:first_name) if params[:term].present?
    respond_with @users
  end
end