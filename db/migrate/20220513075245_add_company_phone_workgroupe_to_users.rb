class AddCompanyPhoneWorkgroupeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :company, :string, null: false, default: ""
    add_column :users, :phone, :string, null: false, unique: true
    add_column :users, :workgroupe, :string

  end
end
