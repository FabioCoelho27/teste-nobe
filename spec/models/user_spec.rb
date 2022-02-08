require "rails_helper"
RSpec.describe User, :type => :model do

  it { is_expected.to respond_to(:name)}
  it {  respond_to(:email)}
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  
  before(:all) do
    @user1 = create(:user)
  end
  
  it "is valid with valid attributes" do
    expect(@user1).to be_valid
  end
  
  it "has a unique user email" do
    user2 = build(:user, email: "teste@teste.com")
    expect(user2).to be_valid
  end
  
  it "is not valid without a password" do 
    user2 = build(:user, password: nil)
    expect(user2).to_not be_valid
  end
  
  it "is not valid without an email" do
    user2 = build(:user, email: nil)
    expect(user2).to_not be_valid
  end
end