class BalanceController < ApplicationController
  def index
    @balances = current_user.account.balances
  end
end
