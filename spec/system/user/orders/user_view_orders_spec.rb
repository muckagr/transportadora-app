require 'rails_helper'

describe 'User visits his shipping company orders page' do
    it 'and see all waiting for acceptance orders' do

        shipping_company_1 = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128',
                corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401',
                price_km: 0.15, price_weight: 0.005, price_dimensions: 90, deadline_km: 1, minimal_price: 40, status: :active)
        shipping_company_2 = ShippingCompany.create!(email_domain: 'papaleguas.com.br', cnpj: '13140157000128', corporate_name: 'PAPAL',
                brand_name: 'Papaléguas Transportadora', full_adress: 'Brasilia - SQS, 409', 
                price_km: 0.13, price_weight: 0.01, price_dimensions: 7, deadline_km: 2, minimal_price: 30, status: :active)
        product_1 = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        product_2 = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Santos, 777',
                distance: 300, weight: 10000, height: 15, width: 20, depth: 15)
        order_1 = Order.create!(shipping_company: shipping_company_1, 
                shipping_price: Order.price_calculator(product_1, shipping_company_1),
                delivery_time: Order.deadline_calculator(product_1, shipping_company_1))
        order_2 = Order.create!(shipping_company: shipping_company_2, 
                shipping_price: Order.price_calculator(product_2, shipping_company_2),
                delivery_time: Order.deadline_calculator(product_2, shipping_company_2))
        user = User.create(email: 'user@phoenix.com.br', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Ordens de Serviço')

        expect(page).to have_content("#{order_1.code}")
        expect(page).to have_content('PHOENIX Transportadora')
        expect(page).to have_content("Rua dos Anjos, 101")
        expect(page).to have_content("40,00")
        expect(page).to have_content("#{order_1.delivery_time}")
        expect(page).to_not have_content("#{order_2.code}")
        expect(page).to_not have_content("Papaléguas Transportadora")
    end

    it 'and see there is no order of service available' do

        shipping_company_1 = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128',
                corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401',
                price_km: 0.15, price_weight: 0.005, price_dimensions: 90, deadline_km: 1, minimal_price: 40, status: :active)
        shipping_company_2 = ShippingCompany.create!(email_domain: 'papaleguas.com.br', cnpj: '13140157000128', corporate_name: 'PAPAL',
                brand_name: 'Papaléguas Transportadora', full_adress: 'Brasilia - SQS, 409', 
                price_km: 0.13, price_weight: 0.01, price_dimensions: 7, deadline_km: 2, minimal_price: 30, status: :active)
        user = User.create(email: 'user@phoenix.com.br', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Ordens de Serviço')

        expect(page).to have_content('Não existem Ordens de Serviço em espera')
    end
end