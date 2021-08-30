class AddTimestampToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :timestamp, :string
  end
end
