# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Admin.create!(email: 'arthurafk@gmail.com', password: 'password')

ShippingCompany.create!(email_domain: 'sedex.com.br', cnpj: '13130158000128', corporate_name: 'SEDEX LTDA',
brand_name: 'SEDEX', full_adress: 'São Paulo - São Paulo, Rua das Parnaíbas, 101') 

User.create!(email: 'arthur@sedex.com.br', password: 'password')
