class TransactionsController < ApplicationController
  
  # POST /transactions
  def create
    @payer = Payer.find_or_create_by(name: transaction_params[:payer])
    
    if @payer
      @payer.update(points: (@payer.points + transaction_params[:points]))
      if @payer.save
        @payer.transactions.create(points: transaction_params[:points], timestamp: (DateTime.strptime(transaction_params[:timestamp], '%Y-%m-%dT%H:%M:%SZ')), remaining_balance: transaction_params[:points], previous_remaining_value: transaction_params[:points])
        render json: @payer.transactions.last, status: :created, location: @payer.transactions.last
      else
        render json: @payer.errors, status: :unprocessable_entity
      end
    else
      render json: @payer.errors, status: :unprocessable_entity
    end
  end

  # PATCH /spend
  def update
    unusedTransactions = Transaction.all.find_all { |transaction| transaction.used == false }

    remainingTotalForAccount = 0

    unusedTransactions.each do |transaction|
      remainingTotalForAccount += transaction.remaining_balance
    end

    if remainingTotalForAccount < transaction_params[:points]
      render json: "Insufficient points"
    else

      @sortedDateTransactions = unusedTransactions.sort_by{ |transaction| transaction.timestamp }
      i = 0
      count = 0
  
      @usedTransactionsForThisSpend = []
      
      until (count >= transaction_params[:points]) || (i == @sortedDateTransactions.length) do
        count += @sortedDateTransactions[i].remaining_balance
        @sortedDateTransactions[i].update(remaining_balance: 0, used: true, previous_remaining_value: @sortedDateTransactions[i].remaining_balance)
        @usedTransactionsForThisSpend.push(@sortedDateTransactions[i])
        @oldestRemainingTransaction = @sortedDateTransactions[i]
        i += 1
      end
      @hashToConsolidate = {}
  
      if @oldestRemainingTransaction && @oldestRemainingTransaction.update(remaining_balance: (count - transaction_params[:points]), used: (count - transaction_params[:points] == 0))
        # amount = 0
        @usedTransactionsForThisSpend.each do |transaction|
          # amount += transaction.previous_remaining_value - transaction.remaining_balance
          # if transaction.previous_remaining_value >= 0
          #   transaction.payer.update(points: (transaction.payer.points + (transaction.remaining_balance - transaction.previous_remaining_value)))
          # else
          #   transaction.payer.update(points: (transaction.payer.points + transaction.previous_remaining_value))
          # end
          if @hashToConsolidate.keys.include?(transaction.payer.name)
            @hashToConsolidate[transaction.payer.name] += (transaction.remaining_balance - transaction.previous_remaining_value)
          else
            @hashToConsolidate[transaction.payer.name] = (transaction.remaining_balance - transaction.previous_remaining_value)
          end
        end
        arrayToBeReturned = []

        @hashToConsolidate.each do |key, value|
          focus = Payer.find_by(name: key)
          focus.update(points: (focus.points + value))
          arrayToBeReturned.push({"payer": key, "points": value})
        end
        render json: arrayToBeReturned
      else
        render json: @oldestRemainingTransaction.errors, status: :unprocessable_entity
      end
    end

  end


  private
    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:payer, :points, :timestamp)
    end
end
