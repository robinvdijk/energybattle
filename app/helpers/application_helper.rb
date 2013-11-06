module ApplicationHelper
	def full_title(page_title)
	  base_title = "Energy Battle"
	  if page_title.empty?
	    base_title
	  else
	    "#{page_title} | #{base_title}"
	  end
  end
  
  def current_user
	  @current_user ||= User.first
  end
end
