class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :weight
      t.integer :height
      t.integer :width
      t.integer :depth
      t.string :code
      t.integer :distance
      t.integer :status
      t.string :customer_address
      t.string :customer_name
      t.belongs_to :shipping_company, null: true, foreign_key: true
      t.belongs_to :order, null: true, foreign_key: true
      t.timestamps
    end
  end
end
