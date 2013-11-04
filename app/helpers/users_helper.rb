module UsersHelper
  def inviteable_users
    if params[:search].blank?
      @users = User.where(["id != ? ", @current_user.id])
    else
      @users = User.search(params[:search]).where(["id != ? ", @current_user.id])
    end
  end

  def find_host(host_id_of_battle)
    @host = User.where(id: host_id_of_battle).first
  end
end