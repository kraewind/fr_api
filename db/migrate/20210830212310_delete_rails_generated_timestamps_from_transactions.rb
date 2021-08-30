class DeleteRailsGeneratedTimestampsFromTransactions < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :created_at
    remove_column :transactions, :updated_at
  end
end
