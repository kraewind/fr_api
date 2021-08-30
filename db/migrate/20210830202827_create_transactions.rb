class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :payer
      t.integer :points

      t.timestamps
    end
  end
end
