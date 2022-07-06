class AddAmountToPays < ActiveRecord::Migration[7.0]
  def change
    add_column :pays, :amount, :integer
  end
end
