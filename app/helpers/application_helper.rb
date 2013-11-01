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

  def host_team_relation
    r = TeamRelation.new
    r.user_id = @current_user.id
    r.battle_id = @battle.id
    r.team = "host_team"
    r.save
  end

  def opponent_team_relation
    r = TeamRelation.new
    r.user_id = @current_user.id
    r.battle_id = @battle.id
    r.team = "opponent_team"
    r.save
  end

  def inviteable_users
    if params[:search].blank?
      @users = User.all :conditions => (@current_user ? ["id != ?", @current_user.id] : [])
    else
      @users = User.search(params[:search]).all :conditions => (@current_user ? ["id != ?", @current_user.id] : [])
    end
  end
end
