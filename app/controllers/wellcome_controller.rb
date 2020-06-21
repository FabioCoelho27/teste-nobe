class WellcomeController < ApplicationController
  def index
    @balance = current_user.account.get_balance
  end
end
