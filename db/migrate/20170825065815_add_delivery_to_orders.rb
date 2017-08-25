class AddDeliveryToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :delivery_date, :date
    add_column :orders, :delivery_timezone, :integer
  end
end
