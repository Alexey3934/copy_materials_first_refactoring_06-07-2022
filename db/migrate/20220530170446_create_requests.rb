class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :material, null: false, foreign_key: true
      t.string :from_user_name

      t.timestamps
    end
  end
end
