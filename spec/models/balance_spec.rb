require 'rails_helper'

RSpec.describe Balance, type: :model do
  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:deposit).optional }
  it { is_expected.to belong_to(:transfer).optional }
  it { is_expected.to belong_to(:withdraw).optional }

end