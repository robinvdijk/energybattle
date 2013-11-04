require 'spec_helper'

feature 'Battle management' do
  scenario 'adds a new battle' do
    current_user = create(:user)
    visit battles_path
    click_link "Nieuwe battle"
      expect(current_path).to eq new_battle_path
      expect(page).to have_content "#{current_user.first_name}"
      expect(page).to have_content "#{current_user.email}"

    expect{click_button "Creër Battle"}.to change(Battle, :count).by(1)

    expect(current_path).to eq battle_path(1)
    expect(page).to have_content "Nieuwe battle aangemaakt"

    within 'h1' do
      expect(page).to have_content 'Pending Battle'
    end
  end     # adds a new battle

  scenario 'change battle status from pending to prepare' do
    current_user = create(:user)
    opponent_user = create(:user)
    battle = create(:battle)
    opponent = create(:team_relation, user_id: opponent_user.id)
    visit battles_path
    click_link('Energy')
      expect(current_path).to eq battle_path(1)

      expect(page).to have_content "#{current_user.first_name}"
      expect(page).to have_content "#{current_user.email}"
      expect(page).to_not have_button "Join"
      save_and_open_page
    end     # change battle status from pending to prepare
end     # Battle management
