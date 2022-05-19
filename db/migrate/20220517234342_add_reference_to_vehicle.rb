class AddReferenceToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicles, :shipping_company, null: false, foreign_key: true
  end
end
