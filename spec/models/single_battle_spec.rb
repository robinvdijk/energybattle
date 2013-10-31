require 'spec_helper'

describe SingleBattle do
  it 'has a valid factory' do
    expect(create(:battle)).to be_valid
  end

  it "is invalid without a host_id" do
    expect(build(:battle, host_id: nil)).to have(1).errors_on(:host_id)
  end

  it "is invalid without a opponent_id" do
    expect(build(:battle, opponent_id: nil)).to have(1).errors_on(:opponent_id)
  end

  it "'s host_id == user.id" do
    user = build(:user)
    battle = build(:battle, host_id: user.id)
    expect(battle.host_id).to eq user.id
  end
end
