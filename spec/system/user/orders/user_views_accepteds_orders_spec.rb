require 'rails_helper'

describe 'User visits his shipping company accepted orders page' do
    it 'and see all accepted orders' do
        shipping_company_1 = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128',
        corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401',
        price_km: 0.15, price_weight: 0.005, price_dimensions: 90, deadline_km: 1, minimal_price: 40, status: :active)
        shipping_company_2 = ShippingCompany.create!(email_domain: 'papaleguas.com.br', cnpj: '13140157000128', corporate_name: 'PAPAL',
        brand_name: 'Papaléguas Transportadora', full_adress: 'Brasilia - SQS, 409', 
        price_km: 0.13, price_weight: 0.01, price_dimensions: 7, deadline_km: 2, minimal_price: 30, status: :active)
        user = User.create(email: 'user@phoenix.com.br', password: 'password')
        product_1 = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        product_2 = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Santos, 777',
                distance: 300, weight: 10000, height: 15, width: 20, depth: 15)
        order_1 = Order.create!(shipping_company: shipping_company_1, 
                shipping_price: Order.price_calculator(product_1, shipping_company_1),
                delivery_time: Order.deadline_calculator(product_1, shipping_company_1), status: :aceita)
        order_2 = Order.create!(shipping_company: shipping_company_2, 
                shipping_price: Order.price_calculator(product_2, shipping_company_2),
                delivery_time: Order.deadline_calculator(product_2, shipping_company_2), status: :aceita)
        product_1.update(order_id: order_1.id, shipping_company: shipping_company_1)
        product_2.update(order_id: order_2.id, shipping_company: shipping_company_2)
        
        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Ordens Aceitas')
        
        expect(page).to have_content(order_1.code)
        expect(page).to have_content(Product.find_by(order_id: order_1).customer_address)
        expect(page).to have_content(Product.find_by(order_id: order_1).customer_address)
        expect(page).to have_content('40,00')
        expect(page).not_to have_content(order_2.code)
        expect(page).not_to have_content(Product.find_by(order_id: order_2).customer_address)
        expect(page).not_to have_content(Product.find_by(order_id: order_2).customer_address)
        expect(page).not_to have_content('139,00')
    end

    it 'and see theres no accepted orders' do
        shipping_company = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128',
        corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401',
        price_km: 0.15, price_weight: 0.005, price_dimensions: 90, deadline_km: 1, minimal_price: 40, status: :active)
        user = User.create(email: 'user@phoenix.com.br', password: 'password')
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        order = Order.create!(shipping_company: shipping_company, 
                shipping_price: Order.price_calculator(product, shipping_company),
                delivery_time: Order.deadline_calculator(product, shipping_company))
        product.update(order_id: order, shipping_company: shipping_company)

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Ordens Aceitas')

        expect(user.shipping_company.orders.aceita.count).to eq 0
        expect(page).not_to have_content(order.code)
    end
end
