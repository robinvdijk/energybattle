require 'spec_helper'

feature "index battle page" do 
	subject { page }

	describe "show all battles" do
		before do 
			visit battles_path
		end

	end
end