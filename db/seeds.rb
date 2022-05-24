# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = Admin.create!(email: 'arthurafk@sistemadefrete.com.br', password: 'password')

shipping_company = ShippingCompany.create!(email_domain: 'sedex.com.br', cnpj: '13130158000128', corporate_name: 'SEDEX LTDA',
brand_name: 'SEDEX', full_adress: 'São Paulo - São Paulo, Rua das Parnaíbas, 101')

shipping_company_2 = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128', corporate_name: 'phoenix transp',
brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401', 
price_km: 0.15, price_weight: 0.005, price_dimensions: 5, deadline_km: 1, status: :active)

shipping_company_3 = ShippingCompany.create!(email_domain: 'papaleguas.com.br', cnpj: '13140157000128', corporate_name: 'PAPAL',
brand_name: 'Papaléguas Transportadora', full_adress: 'Brasilia - SQS, 409', 
price_km: 0.13, price_weight: 0.01, price_dimensions: 7, deadline_km: 2, status: :active)

shipping_company_4 = ShippingCompany.create!(email_domain: 'coyote.com.br', cnpj: '15140158200128', corporate_name: 'COYOTE LTDA',
brand_name: 'Coyote Transportadora', full_adress: 'Unaí - Rua Domingos, 228', 
price_km: 0.15, price_weight: 0.005, price_dimensions: 5, deadline_km: 1, status: :active)

user = User.create!(email: 'arthur@sedex.com.br', password: 'password')
another_user = User.create!(email: 'arthur@phoenix.com.br', password: 'password')

vehicle = Vehicle.create!(license_plate: 'MXK0237', fabrication_year: '2000', car_model: 'UNO', 
car_brand: 'FIAT', max_weight: 100, shipping_company: shipping_company)

vehicle_2 = Vehicle.create!(license_plate: 'MPK9237', fabrication_year: '2005', car_model: 'GOL', 
car_brand: 'VOLKS', max_weight: 100, shipping_company: shipping_company_2)

product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
