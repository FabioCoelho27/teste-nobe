require 'rails_helper'

RSpec.describe Balance, type: :model do
  it { is_expected.to belong_to(:deposit) } 
  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:withdraw) }
  it { is_expected.to belong_to(:transfer) }
  
end
