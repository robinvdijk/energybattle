require 'spec_helper'

describe ReadingsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

end




describe Battle do
  
  describe "Battle Settings" do
    it "should contain right values" do 
      btest = Battle.create!(name: "Battle of the Battles", theme: "Electricity", player_limit: "10", )
      
      expect(Battle.name).to eq([battle of the battles]
      expect(Battle.theme).to eq([electricity]
      expect(Battle.player_limit).to eq([10]
    end
  end
  
end



