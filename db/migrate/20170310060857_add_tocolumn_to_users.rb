class AddTocolumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :to_name, :string
    add_column :users, :to_address, :string
  end
end
