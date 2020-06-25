require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it { is_expected.to belong_to(:account) } 
  it { is_expected.to have_many(:balances) }
  
end