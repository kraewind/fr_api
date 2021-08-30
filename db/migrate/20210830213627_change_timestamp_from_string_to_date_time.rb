class ChangeTimestampFromStringToDateTime < ActiveRecord::Migration[6.1]
  def change
    change_column :transactions, :timestamp, :datetime
  end
end
