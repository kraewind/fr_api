class AddUsedAndRemainingBalanceToTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :used, :boolean, :default => false
    add_column :transactions, :remaining_balance, :integer
  end
end
