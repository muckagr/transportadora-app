class CreateShippingCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_companies do |t|
      t.string :email_domain
      t.string :cnpj
      t.string :corporate_name
      t.string :brand_name
      t.string :full_adress
      t.boolean :status

      t.timestamps
    end
  end
end
