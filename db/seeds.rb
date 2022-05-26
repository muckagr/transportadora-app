# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = Admin.create!(email: 'arthurafk@sistemadefrete.com.br', password: 'password')

shipping_company_1 = ShippingCompany.create!(email_domain: 'sedex.com.br', cnpj: '13130158000128', corporate_name: 'SEDEX LTDA',
brand_name: 'SEDEX', full_adress: 'São Paulo - São Paulo, Rua das Parnaíbas, 101', 
price_km: 0.2, price_weight: 0.007, price_dimensions: 50, deadline_km: 1, minimal_price: 30)

shipping_company_2 = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128', corporate_name: 'phoenix transp',
brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401', 
price_km: 0.15, price_weight: 0.005, price_dimensions: 90, deadline_km: 1, minimal_price: 40)

shipping_company_3 = ShippingCompany.create!(email_domain: 'papaleguas.com.br', cnpj: '13140157000128', corporate_name: 'PAPAL',
brand_name: 'Papaléguas Transportadora', full_adress: 'Brasilia - SQS, 409', 
price_km: 0.13, price_weight: 0.01, price_dimensions: 7, deadline_km: 2, minimal_price: 25)

user_1 = User.create!(email: 'arthur@sedex.com.br', password: 'password')

user_2 = User.create!(email: 'arthur@phoenix.com.br', password: 'password')

user_3 = User.create!(email: 'arthur@papaleguas.com.br', password: 'password')

vehicle = Vehicle.create!(license_plate: 'MXK0237', fabrication_year: '2000', car_model: 'UNO', 
car_brand: 'FIAT', max_weight: 100, shipping_company: shipping_company_1)

vehicle_2 = Vehicle.create!(license_plate: 'MPK9237', fabrication_year: '2005', car_model: 'GOL', 
car_brand: 'VOLKS', max_weight: 100, shipping_company: shipping_company_2)

vehicle_3 = Vehicle.create!(license_plate: 'JJJ9237', fabrication_year: '2005', car_model: 'GOL', 
car_brand: 'VOLKS', max_weight: 100, shipping_company: shipping_company_1)

product_1 = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
distance: 100, weight: 250, height: 10, width: 10, depth: 5)

product_2 = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
distance: 340, weight: 2000, height: 10, width: 10, depth: 10)

product_3 = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
distance: 30, weight: 10000, height: 15, width: 20, depth: 15)
