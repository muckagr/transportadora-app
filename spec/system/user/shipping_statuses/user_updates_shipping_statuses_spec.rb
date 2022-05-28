require 'rails_helper'

describe 'User visits update delivery status' do
    it 'and sees all mandatory fields' do
        shipping_company = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128',
                corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401',
                price_km: 0.15, price_weight: 0.005, price_dimensions: 90, deadline_km: 1, minimal_price: 40, status: :active)
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        order = Order.create!(shipping_company: shipping_company, 
                shipping_price: Order.price_calculator(product, shipping_company),
                delivery_time: Order.deadline_calculator(product, shipping_company), status: :aceita)
        user = User.create(email: 'user@phoenix.com.br', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Atualizar Entrega')

        expect(page).to have_field('Código da Ordem de Serviço')
        expect(page).to have_field('Local da Atualização')
        expect(page).to have_field('Descrição')
    end

        it 'and sucessfully register a delivery status' do
        shipping_company = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128',
                corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401',
                price_km: 0.15, price_weight: 0.005, price_dimensions: 90, deadline_km: 1, minimal_price: 40, status: :active)
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        order = Order.create!(shipping_company: shipping_company, 
                shipping_price: Order.price_calculator(product, shipping_company),
                delivery_time: Order.deadline_calculator(product, shipping_company), status: :aceita)
        user = User.create(email: 'user@phoenix.com.br', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Atualizar Entrega')
        fill_in('Código da Ordem de Serviço', with: "#{order.code}")
        fill_in('Local da Atualização', with: 'CTE | Parintins - AM')
        fill_in('Descrição', with: 'Chegada em CTE | Parintins - AM')
        click_on('Atualizar')
        
        expect(page).to have_content('Status de Entrega atualizado com sucesso!')
    end

    it 'and unsucessfully register a delivery status' do
        shipping_company = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128',
                corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401',
                price_km: 0.15, price_weight: 0.005, price_dimensions: 90, deadline_km: 1, minimal_price: 40, status: :active)
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        order = Order.create!(shipping_company: shipping_company, 
                shipping_price: Order.price_calculator(product, shipping_company),
                delivery_time: Order.deadline_calculator(product, shipping_company))
        user = User.create(email: 'user@phoenix.com.br', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Atualizar Entrega')
        fill_in('Código da Ordem de Serviço', with: "#{order.code} + '18s1'")
        fill_in('Local da Atualização', with: '')
        fill_in('Descrição', with: '')
        click_on('Atualizar')
        
        expect(page).not_to have_content('Status de Entrega atualizado com sucesso!')
        expect(page).to have_content('Falha ao atualizar Status de Entrega!')
        expect(page).to have_content('')
    end
end