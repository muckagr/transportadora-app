class AddDeadlineKmToShippingCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_companies, :deadline_km, :decimal, default: 0
  end
end
