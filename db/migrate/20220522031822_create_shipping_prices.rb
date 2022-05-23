class CreateShippingPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_prices do |t|
      t.decimal :min_m3
      t.decimal :max_m3
      t.decimal :min_weight
      t.decimal :max_weight
      t.decimal :price_km
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
