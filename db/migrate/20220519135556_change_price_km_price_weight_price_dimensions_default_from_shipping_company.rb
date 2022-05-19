class ChangePriceKmPriceWeightPriceDimensionsDefaultFromShippingCompany < ActiveRecord::Migration[7.0]
  def change
    change_column :shipping_companies, :price_km, :decimal, :default => 0
    change_column :shipping_companies, :price_dimensions, :decimal, :default => 0
    change_column :shipping_companies, :price_weight, :decimal, :default => 0
  end
end
