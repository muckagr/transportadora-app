class AddColumnsToShippingCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_companies, :price, :decimal
  end
end
