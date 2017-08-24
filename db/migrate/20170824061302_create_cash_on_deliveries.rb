class CreateCashOnDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :cash_on_deliveries do |t|
      t.integer :less
      t.integer :price

      t.timestamps
    end
  end
end
