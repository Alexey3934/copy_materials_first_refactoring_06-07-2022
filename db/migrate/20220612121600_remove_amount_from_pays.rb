class RemoveAmountFromPays < ActiveRecord::Migration[7.0]
  def change
    remove_column :pays, :amount, :string
  end
end
