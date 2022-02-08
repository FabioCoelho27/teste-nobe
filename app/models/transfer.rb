class Transfer < ApplicationRecord
  belongs_to :account
  has_many :balances
  validates :amount, :numericality => { :greater_than_or_equal_to => 1 }, presence: true 
end




