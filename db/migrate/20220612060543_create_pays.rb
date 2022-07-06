class CreatePays < ActiveRecord::Migration[7.0]
  def change
    create_table :pays do |t|
      t.references :user, null: false, foreign_key: true
      t.string :pay_id
      t.integer :amount
      t.boolean :status

      t.timestamps
    end
  end
end
