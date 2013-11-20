class StaticPagesController < ApplicationController
  skip_before_action :check_signin, only: [:homepage]
  skip_before_action :check_notifications, only: [:homepage]

  def gametype

  end
end