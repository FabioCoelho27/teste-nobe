require 'rails_helper'

RSpec.describe "BankOperations API", type: :request do

  let!(:user)  {create(:user)}
  let!(:account) {create(:account, user_id: user.id)}

  let!(:user_1)  {create(:user)}
  let!(:account_1) {create(:account, user_id: user.id)}
  

  # Bank. As you add validations to Bank, be sure to
  # adjust the attributes here as well.

  let(:valid_session) { {} }

  let(:valid_session) { {"warden.user.user.key" => session["warden.user.user.key"]} }

  let(:valid_attributes) {
    {amount: 100.00, account: user.account, account_to: user_1.account.id}
  }

  let(:invalid_attributes) {
    {amount: nil, account: nil, account_to: nil}
  }


  describe "GET /index" do

    it "renders a successful response" do
      Deposit.create!(account: account, amount: 100.00)
      Transfer.create! valid_attributes
      sign_in user
      get deposits_url
      expect(response).to have_http_status(200)
    end

    it "include transfers response" do
      Deposit.create!(account: account, amount: 100.00)
      transfer = Transfer.create! valid_attributes
      sign_in user
      get transfers_url
      expect(transfer).to have_attributes(:amount => 100.00)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      Deposit.create!(account: account, amount: 100.00)
      transfer = Transfer.create! valid_attributes
      sign_in user_1
      get transfer_url(transfer)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      sign_in user
      transfer = Transfer.create! valid_attributes
      get new_transfer_url(transfer.id)
      expect(response).to be_successful
    end

  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new transfer" do
        Deposit.create!(account: account, amount: 100.00)
        sign_in user
        transfer = Transfer.create! valid_attributes
        post transfers_url, params: { transfer: {account: account.id, amount: 50.00, account_to: account_1.id } }
        expect(Transfer.last).to have_attributes(:amount => transfer.amount)
      end
    end
  end
  
end

