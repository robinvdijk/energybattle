require 'spec_helper'

#Add save_and_open_page to check the effects of a test.
#This is made possible by the launchy gem.

describe "Readings" do
  subject { page }

  describe "page information" do
      before { visit invoeren_path }
      it { should have_title(full_title('Nieuwe meterstanden')) }
  end

  describe "fill out meter readings" do
	let(:submit) { "Meterstand opslaan" }

  	describe "when reading amount is not an integer" do
      it "should be invalid" do
        visit invoeren_path
        fill_in 'reading_amount', :with => "this is not an integer"
        click_button "Meterstand opslaan"
      end
	  end

    describe "when reading amount is an integer" do
      it "should be valid" do
        visit invoeren_path
        fill_in 'reading_amount', :with => "12"
        click_button "Meterstand opslaan"
      end
    end
  end

  describe "show all readings" do
    before do
      visit invoeren_path
      fill_in 'reading_amount', :with => "12"
      click_button "Meterstand opslaan"
      visit meterstanden_path
    end
    it { should have_title(full_title('Mijn meterstanden')) }

    it "should list each reading" do
      Reading.all.each do |reading|
        expect(page).to have_content(reading.amount)
      end
    end
  end
end

