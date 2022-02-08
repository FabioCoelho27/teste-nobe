class Withdraw < ApplicationRecord
  belongs_to :account
  has_many :balances
  after_save :decrement_balance
  validates :amount, :numericality => { :greater_than_or_equal_to => 1 }, presence: true 
  def decrement_balance
    BankOperations.decrement(self.id, self.class.name, 0)
  end
end


