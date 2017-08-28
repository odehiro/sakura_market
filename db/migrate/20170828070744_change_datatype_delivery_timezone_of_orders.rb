class ChangeDatatypeDeliveryTimezoneOfOrders < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :delivery_timezone, :string
  end
end
