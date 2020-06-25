class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]
  before_action :verify_transfer, only: [:create]

  # GET /transfers
  # GET /transfers.json
  def index
    @transfers = Transfer.all
  end

  # GET /transfers/1
  # GET /transfers/1.json
  def show
  end

  # GET /transfers/new
  def new
    @transfer = Transfer.new
  end

  # GET /transfers/1/edit
  def edit
  end

  # POST /transfers
  # POST /transfers.json
  def create
    @transfer = current_user.account.transfers.new(transfer_params)

    respond_to do |format|
      if @transfer.save
        format.html { redirect_to @transfer, notice: 'Transferência realizada com sucesso.' }
        format.json { render :show, status: :created, location: @transfer }
      else
        format.html { render :new }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transfers/1
  # PATCH/PUT /transfers/1.json
  def update
    respond_to do |format|
      if @transfer.update(transfer_params)
        format.html { redirect_to @transfer, notice: 'Transfer was successfully updated.' }
        format.json { render :show, status: :ok, location: @transfer }
      else
        format.html { render :edit }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transfers/1
  # DELETE /transfers/1.json
  def destroy
    @transfer.destroy
    respond_to do |format|
      format.html { redirect_to transfers_url, notice: 'Transfer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def verify_transfer
      account_to = Account.find_by(id: transfer_params[:account_to])
      @transfer = current_user.account.transfers.new(transfer_params)
      last_balance = current_user.account.get_balance
      if @transfer.amount.to_f > last_balance
        @transfer.errors.add(:message, "Insuficient founds to transfer")
        respond_to do |format|
          format.html { render :edit }
          format.json { render json: @transfer.errors, status: :unprocessable_entity}
        end
      elsif account_to.nil?
        @transfer.errors.add(:message, 'Account not found')
        respond_to do |format|
          format.html { render :edit }
          format.json { render json: @transfer.errors, status: :unprocessable_entity}
        end
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transfer_params
      params.require(:transfer).permit(:account_id, :amount, :account_to)
    end
end
