class Account < ApplicationRecord
  belongs_to :user

  

  validates :user_id, uniqueness: true

  enum status: {active:0, inactive:1}

end
