class Account < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :deposits
  has_many :withdraws
  has_many :transfers
  has_many :balances
end
