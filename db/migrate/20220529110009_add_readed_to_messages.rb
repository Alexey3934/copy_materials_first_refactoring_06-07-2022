class AddReadedToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :readed, :boolean
  end
end
