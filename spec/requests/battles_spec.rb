require 'spec_helper'

feature 'Battle management' do
  before(:all) do
    @current_user = create(:user)
    @opponent_user = create(:user)
    @battle = create(:battle, host_id: @current_user.id)
    @opponent = create(:team_relation, user_id: @opponent_user.id, id: 2)
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end

  scenario 'adds a new battle' do
    visit root_path
    first(".theme").click_link("Host")
    first(".theme").click_link("Choose")
      expect(current_path).to eq new_battle_path
      expect(page).to have_content "#{@current_user.first_name}"
      expect(page).to have_content "#{@current_user.email}"
    expect{ click_link "Plaats in overzicht" }.to change(Battle, :count).by(1)
      expect(current_path).to eq battle_path(2)
      expect(page).to have_content "Nieuwe battle aangemaakt"
    within 'h1' do
      expect(page).to have_content 'pending'
    end
  end     # adds a new battle

  scenario 'change battle status from pending to prepare' do
    visit battles_path
    click_link('Energy')
      expect(current_path).to eq battle_path(1)
      expect(page).to have_content "#{@current_user.first_name}"
      expect(page).to have_content "#{@current_user.email}"
      expect(page).to have_content "#{@opponent_user.first_name}"
      expect(page).to have_content "#{@opponent_user.email}"
      expect(page).to_not have_button "Join"
    expect{click_link "Prepare Battle"}.to change(@battle, :status).from("pending").to("Prepare")
  end     # change battle status from pending to prepare

  scenario 'change battle status from prepare to start' do
    visit battle_path(@battle)
    expect{click_link "Start Battle"}.to change(@battle, :status).from("Prepare").to("Start")
  end     # change battle status from prepare to start

  scenario 'able to join battle' do
    visit root_path
    first(".theme").click_link("Join")
      expect(current_path).to eq battles_path
      expect(page).to have_content "energy", "thema", "status"

      it "should list each reading" do
        Reading.all.each do |reading|
          expect(page).to have_content(reading.amount)
        end
      end
  end     # able to join battle
end     # Battle management
