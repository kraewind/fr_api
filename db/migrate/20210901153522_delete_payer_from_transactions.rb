class DeletePayerFromTransactions < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :payer
  end
end
