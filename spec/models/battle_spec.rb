require 'spec_helper'

describe Battle do
  it 'has a valid factory' do
    expect(create(:battle)).to be_valid
  end

  it "is invalid without a host_id" do
    expect(build(:battle, host_id: nil)).to have(1).errors_on(:host_id)
  end

  it "is invalid without a status" do
    expect(build(:battle, status: nil)).to have(1).errors_on(:status)
  end

  it "is invalid without a theme" do
    expect(build(:battle, theme: nil)).to have(1).errors_on(:theme)
  end
end


