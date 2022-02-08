module BankOperations
  def self.get_balance(account)
    balance = Account.find(account).try(:balances).try(:last).try(:amount)
    if balance.present?
      balance
    else
      0
    end
  end

  def self.increment_decrement(id, account_to, amount)
    # decrement self account
    tax = self.get_tax(amount)
    self.decrement(id, "Transfer", tax)

    # increment account_to
    self.increment(account_to, "Transfer", amount)
  end

  def self.increment(id, kind, amount)
    if kind == "Transfer"
      operation = Transfer.create(account_id: id, amount: amount, account_to: id)
    else
      operation = self.get_operation(id, kind)
    end
    last_balance = self.get_balance(operation.account.id)
    increment = operation.amount.to_f
    new_balance = last_balance + increment
    balance = operation.balances.create(
      account_id: operation.account.id, 
      amount: new_balance
    )
  end

  def self.decrement(id, kind, tax)
    operation = self.get_operation(id, kind)
    last_balance = self.get_balance(operation.account.id)
    decrement = operation.amount.to_f + tax
    new_balance = last_balance - decrement
    balance = operation.balances.create(
      account_id: operation.account.id, 
      amount: new_balance
    )
  end

  def self.get_operation(id, kind)
    case kind
      when "Deposit"
        operation = Deposit.find(id)
      when "Withdraw"
        operation = Withdraw.find(id)
      when "Transfer"
        operation = Transfer.find(id)
    else
      
    end
  end

  def self.get_tax(amount, time: Time.now)
    tax = 7
    tax = tax + 10 if amount.to_f >= 1000
    if amount.to_f < 1000 && time.on_weekday?
      tax = 5 if time.hour >= 9 && time.hour <= 18
    end
    if amount.to_f >= 1000 && time.on_weekday?
      tax = 15 if time.hour >= 9 && time.hour <= 18
    end
    tax
  end

end