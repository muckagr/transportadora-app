require 'rails_helper'

describe 'Guest searchs for a shipping status' do
    it 'from index' do

        visit(root_path)
        
        expect(page).to have_field('Código de Rastreio')
        expect(page).to have_button('Procurar')
    end
    
    it 'and find a shipping status of a product' do
        shipping_company = ShippingCompany.create!(email_domain: 'sedex.com.br', cnpj: '13130158000128', corporate_name: 'SEDEX LTDA',
                brand_name: 'SEDEX', full_adress: 'São Paulo - São Paulo, Rua das Parnaíbas, 101', 
                price_km: 0.2, price_weight: 0.007, price_dimensions: 50, deadline_km: 1, minimal_price: 30, status: :active)
        vehicle = Vehicle.create!(license_plate: 'MXK0237', fabrication_year: '2000', car_model: 'UNO', 
                car_brand: 'FIAT', max_weight: 100, shipping_company: shipping_company)
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 250, height: 10, width: 10, depth: 5)
        order = Order.create!(shipping_company: shipping_company, 
                shipping_price: Order.price_calculator(product, shipping_company),
                delivery_time: Order.deadline_calculator(product, shipping_company), status: :aceita)
        product.order_id, product.shipping_company = order, shipping_company
        order.vehicle_id = vehicle
        shipping_status_1 = ShippingStatus.create!(location: 'São Paulo - Maringá', 
                status_description: 'Entrada em CTD Maringá', order_id: order.id)
        shipping_status_2 = ShippingStatus.create!(location: 'São Paulo - Maringá', 
                status_description: 'Saida de CTD Maringá para CTD Porto Alegre', order_id: order.id)
        
        visit(root_path)
        fill_in('Código de Rastreio', with: "#{order.code}")
        click_on('Procurar')

        expect(page).to have_content('Entrada em CTD Maringá')
        expect(page).to have_content("#{shipping_status_1.update_date}")
        expect(page).to have_content('São Paulo - Maringá')
        expect(page).to have_content('Saida de CTD Maringá para CTD Porto Alegre')
        expect(page).to have_content("#{shipping_status_2.update_date}")
    end

    it 'and doesnt find a shipping status' do
        shipping_company = ShippingCompany.create!(email_domain: 'sedex.com.br', cnpj: '13130158000128', corporate_name: 'SEDEX LTDA',
                brand_name: 'SEDEX', full_adress: 'São Paulo - São Paulo, Rua das Parnaíbas, 101', 
                price_km: 0.2, price_weight: 0.007, price_dimensions: 50, deadline_km: 1, minimal_price: 30, status: :active)
        vehicle = Vehicle.create!(license_plate: 'MXK0237', fabrication_year: '2000', car_model: 'UNO', 
                car_brand: 'FIAT', max_weight: 100, shipping_company: shipping_company)
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 250, height: 10, width: 10, depth: 5)
        order = Order.create!(shipping_company: shipping_company, 
                shipping_price: Order.price_calculator(product, shipping_company),
                delivery_time: Order.deadline_calculator(product, shipping_company), status: :aceita)
        product.order_id, product.shipping_company = order, shipping_company
        order.vehicle_id = vehicle
        shipping_status_1 = ShippingStatus.create!(location: 'São Paulo - Maringá', 
                status_description: 'Entrada em CTD Maringá', order_id: order.id)
        shipping_status_2 = ShippingStatus.create!(location: 'São Paulo - Maringá', 
                status_description: 'Saida de CTD Maringá para CTD Porto Alegre', order_id: order.id)
        
        visit(root_path)
        fill_in('Código de Rastreio', with: "#{order.code} + '18ah9")
        click_on('Procurar')

        expect(page).to have_content('Produto não encontrado!')
        expect(page).not_to have_content('Entrada em CTD Maringá')
        expect(page).not_to have_content("#{shipping_status_1.update_date}")
        expect(page).not_to have_content('São Paulo - Maringá')
        expect(page).not_to have_content('Saida de CTD Maringá para CTD Porto Alegre')
        expect(page).not_to have_content("#{shipping_status_2.update_date}")
        end

end