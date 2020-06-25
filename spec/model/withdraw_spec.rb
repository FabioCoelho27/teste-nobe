require 'rails_helper'

RSpec.describe Withdraw, type: :model do
  it { is_expected.to have_many(:balances) }
  it { is_expected.to belong_to(:account) }
  
end
