class Balance < ApplicationRecord
  belongs_to :account
  belongs_to :deposit
  belongs_to :withdraw
  belongs_to :transfer
end
