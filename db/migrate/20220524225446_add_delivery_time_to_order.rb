class AddDeliveryTimeToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :delivery_time, :integer
  end
end
