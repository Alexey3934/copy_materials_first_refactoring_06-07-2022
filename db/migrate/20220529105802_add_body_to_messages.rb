class AddBodyToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :body, :text
  end
end
