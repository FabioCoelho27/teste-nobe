class BalanceController < ApplicationController
  def index
    if params[:start_date].present? && params[:end_date].present?
      @balances = current_user.account.balances.where(created_at: params[:start_date].to_date.params[:end_date].to_date)
      render :index
    end
    @balances = current_user.account.balances 
  end
end
