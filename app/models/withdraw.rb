class Withdraw < ApplicationRecord
  belongs_to :account
  has_many :balances
  after_save :decrement_balance
  validates :amount, numericality: { greater_than_or_equal_to: 1 }
  def decrement_balance
    last_balance = self.account.get_balance
    decrement = self.amount.to_f
    new_balance = last_balance - decrement
    balance = self.balances.create(
      account_id: self.account.id,
      amount: new_balance
    )
  end

end


