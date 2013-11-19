class StaticPagesController < ApplicationController
  skip_before_action :check_signin, only: [:homepage]

  def gametype

  end
end