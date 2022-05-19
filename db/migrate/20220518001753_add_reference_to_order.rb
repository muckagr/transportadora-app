class AddReferenceToOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :shipping_company, null: false, foreign_key: true
  end
end
