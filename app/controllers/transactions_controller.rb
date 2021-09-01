class TransactionsController < ApplicationController
  
  # POST /transactions
  def create
    @transaction = Transaction.new(payer: transaction_params[:payer], points: transaction_params[:points])
    
    parsedTime = DateTime.strptime(transaction_params[:timestamp], '%Y-%m-%dT%H:%M:%SZ')
    
    @transaction.timestamp = parsedTime

    if @transaction.save
      render json: @transaction, status: :created, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH /transactions
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end


  private
    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:points, :timestamp)
    end
end
