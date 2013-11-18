class StaticPagesController < ApplicationController

  def theme
 	 @count_notifications = current_user.notifications.count

  end
  
  def gametype
    
  end
  
end