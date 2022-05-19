class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :weight
      t.integer :height
      t.integer :width
      t.integer :distance
      t.string :delivery_adress
      t.boolean :accepted
      t.string :status

      t.timestamps
    end
  end
end
