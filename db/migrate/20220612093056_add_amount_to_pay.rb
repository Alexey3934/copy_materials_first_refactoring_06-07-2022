class AddAmountToPay < ActiveRecord::Migration[7.0]
  def change
    add_column :pays, :amount, :string
  end
end
