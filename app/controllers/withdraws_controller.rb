class WithdrawsController < ApplicationController
  before_action :set_withdraw, only: [:show, :edit, :update, :destroy]
  before_action :check_balance, only: [:create]

  # GET /withdraws
  # GET /withdraws.json
  def index
    @withdraws = current_user.account.withdraws
  end

  # GET /withdraws/1
  # GET /withdraws/1.json
  def show
  end

  # GET /withdraws/new
  def new
    @withdraw = Withdraw.new
  end

  # GET /withdraws/1/edit
  def edit
  end

  # POST /withdraws
  # POST /withdraws.json
  def create
    @withdraw = current_user.account.withdraws.new(withdraw_params)
    respond_to do |format|
      if @withdraw.save
        format.html { redirect_to @withdraw, notice: 'Saque efetuado com sucesso.' }
        format.json { render :show, status: :created, location: @withdraw }
      else
        format.html { render :new }
        format.json { render json: @withdraw.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /withdraws/1
  # PATCH/PUT /withdraws/1.json
  def update
    respond_to do |format|
      if @withdraw.update(withdraw_params)
        format.html { redirect_to @withdraw, notice: 'Withdraw was successfully updated.' }
        format.json { render :show, status: :ok, location: @withdraw }
      else
        format.html { render :edit }
        format.json { render json: @withdraw.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /withdraws/1
  # DELETE /withdraws/1.json
  def destroy
    @withdraw.destroy
    respond_to do |format|
      format.html { redirect_to withdraws_url, notice: 'Withdraw was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def check_balance
      @withdraw = current_user.account.withdraws.new(withdraw_params)
      last_balance = current_user.account.get_balance
      if @withdraw.amount.to_f > last_balance
        @withdraw.errors.add(:message, "Saldo insuficiente")
        respond_to do |format| 
          format.html { render :edit}
          format.json {render json: @withdraw.erros, status: :unprocessable_entity}
        end
      end  
    end    
    # Use callbacks to share common setup or constraints between actions.
    def set_withdraw
      @withdraw = Withdraw.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def withdraw_params
      params.require(:withdraw).permit(:account_id, :amount)
    end
end
