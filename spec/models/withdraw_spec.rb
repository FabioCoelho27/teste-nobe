require "rails_helper"
RSpec.describe Withdraw, :type => :model do

  it { is_expected.to validate_numericality_of(:amount)}
  it { is_expected.to belong_to(:account)}
  it { is_expected.to respond_to(:account)}
  
  before(:all) do
    @user = create(:user, email:'teste5@teste.com')
    @account = create(:account, user: @user)
    @withdraw1 = create(:withdraw)
  end
  
  it "is valid with valid attributes" do
    expect(@withdraw1).to be_valid
  end
  
  it "has amount only integer" do
    withdraw2 = build(:withdraw, amount: "asdfg")
    expect(withdraw2).to_not be_valid
  end

  it "has amount presence" do
    withdraw2 = build(:withdraw, amount: nil)
    expect(withdraw2).to_not be_valid
  end
end