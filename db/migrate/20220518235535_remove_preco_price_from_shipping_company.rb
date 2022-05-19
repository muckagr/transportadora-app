class RemovePrecoPriceFromShippingCompany < ActiveRecord::Migration[7.0]
  def change
    remove_column :shipping_companies, :price, :decimal
    remove_column :shipping_companies, :preco, :decimal
  end
end
