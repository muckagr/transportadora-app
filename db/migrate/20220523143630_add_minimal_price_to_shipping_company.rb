class AddMinimalPriceToShippingCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_companies, :minimal_price, :decimal, default: 0.0
  end
end
