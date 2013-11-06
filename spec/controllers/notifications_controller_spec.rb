require 'spec_helper'

describe NotificationsController do

  describe "GET 'accept'" do
    it "returns http success" do
      get 'accept'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

end
