class Deposit < ApplicationRecord
  belongs_to :account, dependent: :destroy
  has_many :balances
  after_save :increment_balance
  validates :amount, numericality: true, presence:true
  def increment_balance
   BankOperations.decrement(self.id, self.class.name, 0)
  end
end