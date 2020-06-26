require "rails_helper"
RSpec.describe Transfer, :type => :model do
  
  before(:all) do
    @user = create(:user, email:'teste4@teste.com')
    @account = create(:account, user: @user)
    @transfer1 = create(:transfer)
  end
  
  it "is valid with valid attributes" do
    expect(@transfer1).to be_valid
  end
  
  it "has amount only integer" do
    transfer2 = build(:transfer, amount: "asdfg", account_to: 1)
    expect(transfer2).to_not be_valid
  end

  it "has amount presence" do
    transfer2 = build(:transfer, amount: nil, account_to: 1)
    expect(transfer2).to_not be_valid
  end
end