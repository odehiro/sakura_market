class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.binary :image
      t.integer :price
      t.text :caption
      t.boolean :display
      t.integer  :order_index

      t.timestamps
    end
  end
end
