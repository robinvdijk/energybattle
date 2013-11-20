require 'spec_helper'

feature 'Battle management' do
  before(:each) do
    @current_user = create(:user)
  end

  scenario 'adds a new battle' do
    visit root_path
    first(".theme").click_link("Host")
    first(".theme").click_link("Choose")
      expect(current_path).to eq new_battle_path
      save_and_open_page
      expect(page).to have_content "#{@current_user.name}"
      expect(page).to have_content "#{@current_user.email}"
      fill_in 'battle_title', :with => "Test"
      fill_in 'battle_player_limit', :with => "12"
    expect{click_button "Plaats in overzicht"}.to change(Battle, :count).by(1)

    expect(current_path).to eq battle_path(1)
    expect(page).to have_content "Nieuwe battle aangemaakt"

    within 'h1' do
      expect(page).to have_content 'pending'
    end
  end     # adds a new battle

  scenario 'change battle status from pending to prepare' do
    opponent_user = create(:user)
    battle = create(:battle, host_id: @current_user.id)
    opponent = create(:team_relation, user_id: opponent_user.id, id: 2)
    visit battles_path
    click_link('Energy')
      expect(current_path).to eq battle_path(1)
      expect(page).to have_content "#{@current_user.first_name}"
      expect(page).to have_content "#{@current_user.email}"

      expect(page).to have_content "#{opponent_user.first_name}"
      expect(page).to have_content "#{opponent_user.email}"

      expect(page).to_not have_button "Join"
      expect{click_button "Prepare Battle"}.to change(Battle, :status).to("Prepare")
    end     # change battle status from pending to prepare
end     # Battle management