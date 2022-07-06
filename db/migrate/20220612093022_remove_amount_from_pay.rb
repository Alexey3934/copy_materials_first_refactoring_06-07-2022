class RemoveAmountFromPay < ActiveRecord::Migration[7.0]
  def change
    remove_column :pays, :amount, :integer
  end
end
