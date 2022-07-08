require 'rails_helper'

describe 'User visits his shipping company orders page' do
    it 'and delegate a car for a order of service' do

        shipping_company = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128',
                corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401',
                price_km: 0.15, price_weight: 0.005, price_dimensions: 90, deadline_km: 1, minimal_price: 40, status: :active)
        vehicle_1 = Vehicle.create!(license_plate: 'MXK0237', fabrication_year: '2000', car_model: 'UNO', 
                car_brand: 'FIAT', max_weight: 100, shipping_company: shipping_company)
        vehicle_2 = Vehicle.create!(license_plate: 'MPK9237', fabrication_year: '2005', car_model: 'GOL', 
                car_brand: 'VOLKS', max_weight: 100, shipping_company: shipping_company)
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        order = Order.create!(shipping_company: shipping_company, 
                shipping_price: Order.price_calculator(product, shipping_company),
                delivery_time: Order.deadline_calculator(product, shipping_company))
        user = User.create(email: 'user@phoenix.com.br', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Ordens Pendentes')
        select('UNO', from: 'Veículo')

        expect(page).to have_select('Veículo', selected: 'UNO')
    end
    
    it 'and sucessfully accepts an order of service' do
        
        shipping_company = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128',
                corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401',
                price_km: 0.15, price_weight: 0.005, price_dimensions: 90, deadline_km: 1, minimal_price: 40, status: :active)
        vehicle_1 = Vehicle.create!(license_plate: 'MXK0237', fabrication_year: '2000', car_model: 'UNO', 
                car_brand: 'FIAT', max_weight: 100, shipping_company: shipping_company)
        vehicle_2 = Vehicle.create!(license_plate: 'MPK9237', fabrication_year: '2005', car_model: 'GOL', 
                car_brand: 'VOLKS', max_weight: 100, shipping_company: shipping_company)
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        order = Order.create!(shipping_company: shipping_company, 
                shipping_price: Order.price_calculator(product, shipping_company),
                delivery_time: Order.deadline_calculator(product, shipping_company))
        user = User.create(email: 'user@phoenix.com.br', password: 'password')
                
        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Ordens Pendentes')
        within("//div[@id='#{order.code}']") do
            select('UNO', from: 'Veículo')
            click_on('Aceitar Ordem de Serviço')
        end
        expect(current_path).to eq user_shipping_company_orders_path(shipping_company)
        expect(page).to have_content('Ordem de Serviço aceita!')
        expect(page).to_not have_content("#{order.code}")
    end

    it 'and sucessfully rejects an order of service' do
        
        shipping_company = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128',
                corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401',
                price_km: 0.15, price_weight: 0.005, price_dimensions: 90, deadline_km: 1, minimal_price: 40, status: :active)
        vehicle_1 = Vehicle.create!(license_plate: 'MXK0237', fabrication_year: '2000', car_model: 'UNO', 
                car_brand: 'FIAT', max_weight: 100, shipping_company: shipping_company)
        vehicle_2 = Vehicle.create!(license_plate: 'MPK9237', fabrication_year: '2005', car_model: 'GOL', 
                car_brand: 'VOLKS', max_weight: 100, shipping_company: shipping_company)
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        product_2 = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 340, weight: 3000, height: 10, width: 10, depth: 10)
        order_1 = Order.create!(shipping_company: shipping_company, 
                shipping_price: Order.price_calculator(product, shipping_company),
                delivery_time: Order.deadline_calculator(product, shipping_company))
        product.update(order_id: order_1.id)
        order_2 = Order.create!(shipping_company: shipping_company, 
                shipping_price: Order.price_calculator(product_2, shipping_company),
                delivery_time: Order.deadline_calculator(product_2, shipping_company))
        user = User.create(email: 'user@phoenix.com.br', password: 'password')
                
        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Ordens Pendentes')
        within("//div[@id='#{order_1.code}']") do
            select('UNO', from: 'Veículo')
            click_on('Recusar Ordem de Serviço')
        end
                
        expect(current_path).to eq user_shipping_company_orders_path(shipping_company)
        expect(page).to have_content("#{order_2.code}")
        expect(page).to have_content('Ordem de Serviço recusada!')
        expect(page).to_not have_content("#{order_1.code}")
    end

    it 'and needs to be logged in' do
        shipping_company = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128',
                corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401',
                price_km: 0.15, price_weight: 0.005, price_dimensions: 90, deadline_km: 1, minimal_price: 40, status: :active)
        vehicle = Vehicle.create!(license_plate: 'MXK0237', fabrication_year: '2000', car_model: 'UNO', 
                car_brand: 'FIAT', max_weight: 100, shipping_company: shipping_company)
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        order = Order.create!(shipping_company: shipping_company, 
                shipping_price: Order.price_calculator(product, shipping_company),
                delivery_time: Order.deadline_calculator(product, shipping_company))
        product.update(order_id: order.id)

        visit(edit_user_shipping_company_order_path(shipping_company, order))

        expect(current_path).to eq new_user_session_path
        expect(page). to have_content('Para continuar, faça login ou registre-se.')
    end
end