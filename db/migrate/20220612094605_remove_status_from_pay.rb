class RemoveStatusFromPay < ActiveRecord::Migration[7.0]
  def change
    remove_column :pays, :status, :boolean
  end
end
