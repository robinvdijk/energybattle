module ApplicationHelper
  def full_title(page_title)
    base_title = "Energy Battle"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end

  def current_user
    @current_user ||= User.first
  end

  # def accept
  #   relation = TeamRelation.where(:user_id => @notification.receiver_id, :battle_id => @notification.battle_id, :status => 'invited').first
  #   if relation
  #     relation.update_attributes(status: 'joined')
  #     @notification.destroy
  #      redirect_to battles_path(@notification.battle_id), notice: "Je hebt een battle succesvol gejoined!"
  #   else
  #      redirect_to root_path, error: "Er is iets fouts gegaan"
  #   end
  # end
end
