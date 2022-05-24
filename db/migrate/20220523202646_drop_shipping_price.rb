class DropShippingPrice < ActiveRecord::Migration[7.0]
  def change
    drop_table :shipping_prices
  end
end
