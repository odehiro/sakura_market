class ChangeDatatypeOrderOfFoods < ActiveRecord::Migration[5.0]
  def change
    change_column :foods, :order, 'integer USING CAST(:order AS integer)'
  end
end
