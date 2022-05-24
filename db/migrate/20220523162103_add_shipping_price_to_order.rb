class AddShippingPriceToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :shipping_price, :decimal
  end
end
