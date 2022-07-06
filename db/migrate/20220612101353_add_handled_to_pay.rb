class AddHandledToPay < ActiveRecord::Migration[7.0]
  def change
    add_column :pays, :handled, :boolean
  end
end
