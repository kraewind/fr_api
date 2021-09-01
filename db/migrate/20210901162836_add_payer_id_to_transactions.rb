class AddPayerIdToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_reference :transactions, :payer, index: true
    add_foreign_key :transactions, :payers
  end
end
