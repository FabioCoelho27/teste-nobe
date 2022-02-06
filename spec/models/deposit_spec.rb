require "rails_helper"
RSpec.describe Deposit, :type => :model do

  it { is_expected.to belong_to(:account) }
  it { is_expected.to respond_to(:increment_balance) }
  it { is_expected.to respond_to(:amount) }
  it { is_expected.to have_many(:balances)}
  
  before(:all) do
    @user = create(:user, email:'teste3@teste.com')
    @account = create(:account, user: @user)
    @deposit1 = create(:deposit)
  end
  context 'valids attributes' do 
    it "is valid with valid attributes" do
      expect(@deposit1).to be_valid
    end
  end 
  
  context 'Invalids attributes' do 
    it "has amount only integer" do
      deposit2 = build(:deposit, amount: "asdfg")
      expect(deposit2).to_not be_valid
    end

    it "has amount presence" do
      deposit2 = build(:deposit, amount: nil)
      expect(deposit2).to_not be_valid
    end
  end 
end