class AddPriceKmPriceWeightPriceDimensionsToShippingCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_companies, :price_km, :decimal
    add_column :shipping_companies, :price_weight, :decimal
    add_column :shipping_companies, :price_dimensions, :decimal
  end
end
