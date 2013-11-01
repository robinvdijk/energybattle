module ApplicationHelper

	def full_title(page_title)
	  base_title = "Energy Battle"
	  if page_title.empty?
	    base_title
	  else
	    "#{page_title} | #{base_title}"
	  end
	end

  def host_team_relation
    r = TeamRelation.new
    r.user_id = @current_user.id
    r.single_battle_id = @single_battle.id
    r.team = "host_team"
    r.save
  end

  def opponent_team_relation
    r = TeamRelation.new
    r.user_id = @current_user.id
    r.single_battle_id = @single_battle.id
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
