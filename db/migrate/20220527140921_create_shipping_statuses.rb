class CreateShippingStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_statuses do |t|
      t.string :update_date
      t.references :order, null: false, foreign_key: true
      t.string :location
      t.string :status_description

      t.timestamps
    end
  end
end
