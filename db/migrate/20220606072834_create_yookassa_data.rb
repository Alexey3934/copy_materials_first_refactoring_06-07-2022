class CreateYookassaData < ActiveRecord::Migration[7.0]
  def change
    create_table :yookassa_data do |t|
      t.string :token
      t.string :shop_id

      t.timestamps
    end
  end
end
