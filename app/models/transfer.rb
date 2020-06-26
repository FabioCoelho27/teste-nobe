class Transfer < ApplicationRecord
  belongs_to :account
  has_many :balances
  validates :amount, numericality: true, presence: true 
end




