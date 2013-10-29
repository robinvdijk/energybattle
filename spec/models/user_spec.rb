require 'spec_helper'

describe User do
  it 'has many single_battles' do
    expect(create(:user_with_single_battle).single_battles.count).to eq 1
  end
end
