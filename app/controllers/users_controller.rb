class UsersController < ApplicationController

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

  def show
  	@user = User.find(params[:id])
  end
end