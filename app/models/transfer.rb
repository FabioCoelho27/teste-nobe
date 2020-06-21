class Transfer < ApplicationRecord
  belongs_to :account
  has_many :balances
  after_save :increment_decrement_balance

  def increment_decrement_balance
    #decrement self account
    last_balance = self.account.get_balance
    decrement = self.amount.to_f
    new_balance = last_balance - decrement
    balance = self.balances.create(
      account_id: self.account.id,
      amount: new_balance
    )

    # increment account_to
    account = Account.find(self.account_to.to_i)
    last_balance = account.get_balance
    increment = self.amount.to_f
    new_balance = last_balance + increment
    balance = account.balances.create(
      account_id: account.id,
      account: new_balance
    )
  end



end

