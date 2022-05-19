class RemoveStatusFromShippingCompany < ActiveRecord::Migration[7.0]
  def change
    remove_column :shipping_companies, :status, :string
  end
end
