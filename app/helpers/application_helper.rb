module ApplicationHelper

	def full_title(page_title)
	  base_title = "Energy Battle"
	  if page_title.empty?
	    base_title
	  else
	    "#{page_title} | #{base_title}"
	  end
	end

  def find_host(host_id_of_battle)
    @host = User.where(id: host_id_of_battle).first
  end

  def inviteable_users
    if params[:search].blank?
      @users = User.where(["id != ? ", @current_user.id])
    else
      @users = User.search(params[:search]).where(["id != ? ", @current_user.id])
    end
  end
end
