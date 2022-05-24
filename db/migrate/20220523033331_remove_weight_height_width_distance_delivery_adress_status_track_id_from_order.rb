class RemoveWeightHeightWidthDistanceDeliveryAdressStatusTrackIdFromOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :weight, :integer
    remove_column :orders, :height, :integer
    remove_column :orders, :width, :integer
    remove_column :orders, :distance, :integer
    remove_column :orders, :delivery_adress, :string
    remove_column :orders, :accepted, :string
    remove_column :orders, :status, :integer
    remove_column :orders, :track_id, :string
  end
end
