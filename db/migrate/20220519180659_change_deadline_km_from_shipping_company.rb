class ChangeDeadlineKmFromShippingCompany < ActiveRecord::Migration[7.0]
  def change
    change_column :shipping_companies, :deadline_km, :integer, :default => 0
  end
end
