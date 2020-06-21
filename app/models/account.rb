class Account < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :deposits
  has_many :withdraws
  has_many :transfers
  has_many :balances


  def get_balance
    balance = self.try(:balances).try(:last).try(:amount)
    if balance.present?
      balance
    else
      0
    end
  end
end