class Balance < ApplicationRecord
  belongs_to :account
  belongs_to :deposit
  belongs_to :withdraw
  belongs_to :transfer

  def get_type
    if self.withdraw.present?
      transaction_type = 'Saque'
    elsif self.deposit.present?
      transaction_type = 'Depósito'
    elsif self.transfer.present?
      transaction_type = 'Transferência'
    else
      transaction_type = 'Desconhecida'
    end
  end

  def get_value
    if self.withdraw.present?
      value = self.withdraw.amount
    elsif self.deposit.present?
      value = self.deposit.amount
    elsif self.transfer.present?
      value = self.transfer.amount
    else
      value = 0
    end
  end

end

