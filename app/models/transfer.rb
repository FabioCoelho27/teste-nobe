class Transfer < ApplicationRecord
  belongs_to :account
  has_many :balances
  after_save :increment_decrement_balance
  validates :amount, numericality: { greater_than_or_equal_to: 1 }
  def increment_decrement_balance
    # decrement self account
    last_balance = self.account.get_balance
    decrement = self.amount.to_f + get_tax
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
      amount: new_balance
    )
  end

  def get_tax
    if self.amount.to_f >= 1000
      tax = 10
    elsif Time.now.on_weekday?
      if Time.now >= "09:00".to_time && Time.now <= "18:00".to_time
        tax = 5
      end
    else
      tax = 7
    end
  end

end




