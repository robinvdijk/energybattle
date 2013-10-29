require 'spec_helper'

describe SingleBattle do
  it 'has a valid factory' do
    expect(create(:user_with_single_battle)).to be_valid
  end

  it "is invalid without a user_id" do
    expect(build(:single_battle, user_id: nil)).to have(1).errors_on(:user_id)
  end

  it "is invalid without a opponent_id" do
    expect(build(:single_battle, opponent_id: nil)).to have(1).errors_on(:opponent_id)
  end

  it "is invalid without a winner_id" do
    expect(build(:single_battle, winner_id: nil)).to have(1).errors_on(:winner_id)
  end

  it "'s host_id == user_id" do
    battle = build(:user_with_single_battle).single_battles.first
    user = battle.user.id
    expect(battle.user_id).to eq user
  end
end
