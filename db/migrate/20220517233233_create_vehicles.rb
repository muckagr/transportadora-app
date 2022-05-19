class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :license_plate
      t.string :fabrication_year
      t.string :car_model
      t.integer :max_weight
      t.string :car_brand

      t.timestamps
    end
  end
end
