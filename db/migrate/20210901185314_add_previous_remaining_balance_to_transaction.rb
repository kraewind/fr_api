class AddPreviousRemainingBalanceToTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :previous_remaining_value, :integer
  end
end
