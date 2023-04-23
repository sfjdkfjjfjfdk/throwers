class AddNameToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :name, :string
  end
end
